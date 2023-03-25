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
        var requestURL = URLRequest(url: urlComponents.url!)
        requestURL.httpMethod = "POST"
        requestURL.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await session.data(for:requestURL)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(statusCode) else {
            throw WiseError.invalidServerResponse
        }
        return CreditsParser().getCredits(data: data)
    }
    
    
    public func getScoreReport(studNo:String) async throws -> ScoreReport {
        let urlComponents = URLFactory.getScoreReportURLComponents(studNo: studNo)
        var requestURL = URLRequest(url: urlComponents.url!)
        requestURL.httpMethod = "POST"
        requestURL.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await session.data(for:requestURL)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(statusCode) else {
            throw WiseError.invalidServerResponse
        }
        return ScoreReportParser().getScoreReport(data: data)
    }
    
    public func logInAndGetStudentNo(userID:String, password:String) async throws -> String {
        let loginURLComponents = URLFactory.getLoginURLComponents(userID:userID, password: password)
        var requestURL = URLRequest(url: loginURLComponents.url!)
        requestURL.httpMethod = "POST"
        requestURL.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let (data, response) = try await session.data(for:requestURL)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(statusCode) else {
            throw WiseError.invalidServerResponse
        }
        guard let resultString = String(data: data,encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))), resultString != "" else {
            throw WiseError.dataMissing
        }
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
}
