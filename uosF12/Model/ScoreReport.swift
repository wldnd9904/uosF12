import Foundation

//성적표
public struct ScoreReport {
    public var totalPnt:Int = 0//총학점
    public var totalSum:Float = 0//총점수
    public var totalAvg:Float = 0//총평점
    public var pnt1:Int = 0//전공학점
    public var pnt2:Int = 0//교양학점
    public var pnt3:Int = 0//일선학점
    public var pnt4:Int = 0//기타학점
    public var sum1:Float = 0//전공점수합
    public var sum2:Float = 0//교양점수합
    public var sum3:Float = 0//일선점수합
    public var sum4:Float = 0//기타점수합
    public var avg1:Float = 0//전공평점
    public var avg2:Float = 0//교양평점
    public var avg3:Float = 0//일선평점
    public var avg4:Float = 0//기타평점
    public var Subjects:[Subject] = []//과목리스트
    public init(){
    }
}

//학기
public enum Semester: String, CaseIterable{
    case spring = "1학기"
    case summer = "여름계절수업"
    case fall = "2학기"
    case winter = "겨울계절수업"
}
//교과구분
public enum SubjectDiv: String, CaseIterable{
    case A01 = "교양선택"
    case A02 = "교양필수"
    case A03 = "전공필수"
    case A04 = "전공선택"
    case A05 = "일반선택"
    case A06 = "ROTC"
    case A07 = "교직"
    case A08 = "교환학점"
    case A09 = "선수"
    case A10 = "기초선택"
}

//과목 성적표
public struct Subject: Identifiable {
    public var id: Int = 0
    public var year:Int = 0//학년도
    public var semester:Semester = .spring//학기 enum
    public var subjectCode:String = "00000"//과목번호
    public var korName:String = "과목명"//한글과목명
    public var engName:String = "SubName"//영문과목명
    public var subjectDiv:SubjectDiv = .A01//교과구분 enum
    public var pnt:Int = 1//학점
    public var grade:Float = 1.0//등급
    public var valid:Bool = false//성적유효여부
    public var retry:Bool = false//재수강여부

    public static let demo = Subject(id:0, year:2020, semester:.fall, subjectCode: "12345", korName: "마이크로프로세서및실습", engName: "Microprocessor Design and Experiment", subjectDiv: .A01, pnt:3, grade:4.0, valid:true, retry:true)
}
