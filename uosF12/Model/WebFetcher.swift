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
    private var cookie: [HTTPCookie]?
    private init() {}
    
    public func getScoreReport(completion: @escaping (Result<ScoreReport, Error>) -> ()){
        // [URL 지정 및 파라미터 값 지정 실시]
        let urlComponents = URLFactory.getScoreReportURLComponents(studno: "")
        var requestURL = URLRequest(url: urlComponents.url!)
        requestURL.httpMethod = "POST"
        requestURL.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: requestURL) { data, response, error in
            guard error == nil else {
                completion(.failure(WiseError.transportError))
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(statusCode) else {
                completion(.failure(WiseError.transportError))
                return
            }
            print(data!)
            completion(.success(ScoreReportParser().getScoreReport(data: data!)))
        }.resume()
    }
    
    public func login(portalID:PortalID, completion: @escaping (Result<Any, Error>) -> ()){
        // [URL 지정 및 파라미터 값 지정 실시]
        let loginURLComponents = URLFactory.getLoginURLComponents(portalID: portalID)
        var requestURL = URLRequest(url: loginURLComponents.url!)
        requestURL.httpMethod = "POST"
        requestURL.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        session.dataTask(with: requestURL) { data, response, error in
            guard error == nil else {
                completion(.failure(WiseError.transportError))
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200..<300).contains(statusCode) else {
                completion(.failure(WiseError.transportError))
                return
            }
            guard let resultString = String(data: data!,encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))) else {
                completion(.failure(WiseError.dataMissing))
                return
            }
            guard resultString.contains("로그아웃") else {
                if resultString.contains("잘못된 로그인 정보") || resultString.contains("입력하지") {
                    completion(.failure(WiseError.loginFailed))
                } else if resultString.contains("한 개의 브라우저") {
                    completion(.failure(WiseError.duplicated))
                }else {
                    completion(.failure(WiseError.unknown))
                }
                return
            }
            self.cookie = HTTPCookie.cookies(withResponseHeaderFields: (response as? HTTPURLResponse)?.allHeaderFields as! [String : String], for: (loginURLComponents.url)!)
            completion(.success(true))
        }.resume()
    }
}
