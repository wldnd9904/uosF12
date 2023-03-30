//
//  WebFetcher.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/20.
//

import Foundation

public class WebFetcher {
    public static let shared = WebFetcher()
    private let session = URLSession(configuration: .default)
    private init() {}
    
    public func getCredits(studNo:String) async throws -> Credits {
        let urlComponents = URLFactory.getCreditsURLComponents(studNo: studNo)
        let data = try await POST(urlComponents)
        return CreditsParser().getCredits(data: data)
    }
    
    public func getScoreReport(studNo:String) async throws -> ScoreReport {
        let urlComponents = URLFactory.getScoreReportURLComponents(studNo: studNo)
        let data = try await POST(urlComponents)
        return ScoreReportParser().getScoreReport(data: data)
    }
    
    public func logInAndGetStudentNo(userID:String, password:String) async throws -> String {
        let urlComponents = URLFactory.getLoginURLComponents(userID:userID, password: password)
        let data = try await POST(urlComponents)
        let resultString = try getString(data)
        
        guard resultString.contains("로그아웃") else {
            if resultString.contains("잘못된 로그인 정보") || resultString.contains("입력하지") {
                throw WiseError.loginFailed
            } else if resultString.contains("한 개의 브라우저") {
                throw WiseError.duplicated
            } else {
                throw WiseError.unknown
            }
        }
        guard let studNoRange = resultString.range(of:"\\[\\d{10}\\]",options: .regularExpression) else {
            throw WiseError.dataMissing
        }
        var studNo = resultString[studNoRange]
        studNo.removeLast()
        studNo.removeFirst()
        return String(studNo)
    }
    public func getCurrentYearAndSemester(studNo:String) async throws -> (String, String) {
            let urlComponents = URLFactory.getCurrentSemesterURLComponents(studNo: studNo)
            let data = try await POST(urlComponents)
            return SemesterParser().getYearAndSemester(data: data)
    }
    
    public func getRegistration(studNo:String, year:String, semester:String) async throws -> [Registration] {
        let urlComponents = URLFactory.getCourseRegistrationURLComponents(studNo: studNo, year: year, semester: semester)
        let data = try await POST(urlComponents)
        return RegistrationParser().getRegistrations(data: data)
    }
    
    public func getF12Availability() async throws -> Bool {
        let urlComponents = URLFactory.getF12AvailabilityURLComponents()
        let data = try await POST(urlComponents)
        let resultString = try getString(data)
        return !resultString.contains("기간이 아닙니다.")
    }
    
    public func getF12(studNo:String, year:String, semester:String) async throws -> F12 {
        let urlComponents = URLFactory.getF12URLComponents(studNo: studNo, year: year, semester: semester)
        let data = try await POST(urlComponents)
        let resultString = try getString(data)
        if resultString.contains("세션") {
            throw WiseError.sessionExpired
        }
        return F12Parser().getF12(data: data)
    }
    
    public func logout() async throws {
        let urlComponents = URLFactory.getLogoutURLComponents()
        let data = try await POST(urlComponents)
        let resultString = try getString(data)
        guard resultString.contains("비밀번호") else {
                throw WiseError.unknown
        }
    }
    
    func POST(_ urlComponents: URLComponents) async throws -> Data {
        var requestURL = URLRequest(url: urlComponents.url!)
        requestURL.httpMethod = "POST"
        requestURL.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await session.data(for:requestURL)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(statusCode) else {
            throw WiseError.invalidServerResponse
        }
        return data
    }
    
    func getString(_ data:Data) throws -> String {
        guard let resultString = String(data: data,encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))), resultString != "" else {
            throw WiseError.dataMissing
        }
        return resultString
    }
}
