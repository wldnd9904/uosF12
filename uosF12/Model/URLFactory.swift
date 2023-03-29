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

    public static func getLogoutURLComponents() -> URLComponents {
        var ret:URLComponents = URLComponents(string: "https://wise.uos.ac.kr/uosdoc/com.StuLogin.serv")!
        let params: [String: String] = [
            "_COMMAND_": "LOGOUT",
            "strSystem": "",
            "strTarget": "MAIN"]
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
    
    public static func getCreditsURLComponents(studNo: String) -> URLComponents {
        var ret:URLComponents = URLComponents(string: "https://wise.uos.ac.kr/uosdoc/ugt.UgtPlanCmpSubject.do")!
        let params: [String: String] = [
            "strStudId" : studNo,
            "_user_info": studNo,
            "_COMMAND_" : "List",
            "_XML_" : "XML",
            "_strMenuId" : "stud00560"]
        ret.queryItems = params.map{URLQueryItem(name: $0.key, value: $0.value)}
        return ret
    }
    
    public static func getCurrentSemesterURLComponents(studNo: String) -> URLComponents {
        var ret:URLComponents = URLComponents(string: "https://wise.uos.ac.kr/uosdoc/ucr.UcrTlsnAplyCnfmPrt.do")!
        let params: [String: String] = [
            "strSchYear" : "",
            "strSmtCd": "",
            "_code_smtList" : "CMN31",
            "_COMMAND_" : "onload",
            "_XML_" : "XML",
            "_strMenuId" : "stud00205"]
        ret.queryItems = params.map{URLQueryItem(name: $0.key, value: $0.value)}
        return ret
    }
    
    public static func getCourseRegistrationURLComponents(studNo: String, year: String, semester: String) -> URLComponents {
        var ret:URLComponents = URLComponents(string: "https://wise.uos.ac.kr/uosdoc/ucr.UcrTlsnAplyCnfmPrt.do")!
        let params: [String: String] = [
            "strSchYear" : year,
            "strSmtCd" : semester,
            "strUserId" : studNo,
            "strTitle" : "수강신청확인서",
            "_COMMAND_" : "list",
            "_XML_" : "XML",
            "_strMenuId" : "stud00205"]
        ret.queryItems = params.map{URLQueryItem(name: $0.key, value: $0.value)}
        return ret
    }
    
    public static func getF12AvailabilityURLComponents() -> URLComponents {
        var ret:URLComponents = URLComponents(string: "https://wise.uos.ac.kr/uosdoc/ugd.UgdOtcmInq.do")!
        let params: [String: String] = [
            "_dept_authDept" : "auth",
            "_code_smtList": "CMN31",
            "_COMMAND_" : "onload",
            "_XML_" : "XML",
            "_strMenuId" : "stud00320"]
        ret.queryItems = []
        _ = params.map{ret.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))}
        return ret
    }
    
    public static func getF12URLComponents(studNo: String, year: String, semester: String) -> URLComponents {
        var ret:URLComponents = URLComponents(string: "https://wise.uos.ac.kr/uosdoc/ugd.UgdOtcmInq.do")!
        let params: [String: String] = [
            "strSchYear" : year,
            "strSmtCd" : semester,
            "strUserId" : studNo,
            "strDiv" : "2",
            "_COMMAND_" : "list",
            "_XML_" : "XML",
            "_strMenuId" : "stud00320"]
        ret.queryItems = []
        _ = params.map{ret.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))}
        return ret
    }
}
