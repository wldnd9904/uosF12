//
//  URLStorage.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/19.
//

import Foundation

public class URLFactory {
    public static func getLoginURLComponents(userID:String, password:String) -> URLComponents {
        var ret:URLComponents = URLComponents(string: "https://wise.uos.ac.kr/uosdoc/com.StuLogin.serv")!
        let params: [String: String] = [
            "_COMMAND_": "LOGIN",
            "strTarget": "MAIN",
            "strIpAddr": "123.123.123.123",
            "strMacAddr": "123.123.123.123",
            "login_div_1_nm": "%C7%D0%BB%FD",
            "strLoginId": userID,
            "strLoginPw": password]
        ret.queryItems = []
        _ = params.map{ret.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))}
        return ret
    }
    
    public static func getScoreReportURLComponents(studNo: String) -> URLComponents {
        var ret:URLComponents = URLComponents(string: "https://wise.uos.ac.kr/uosdoc/ugd.UgdOtcmSheetInq.do")!
        let params: [String: String] = [
            "requestList" : "",
            "strStudId": studNo,
            "_COMMAND_" : "list",
            "_XML_" : "XML",
            "_strMenuId" : "stud00300"]
        ret.queryItems = []
        _ = params.map{ret.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))}
        return ret
    }
}
