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
    
    public static let demo = ScoreReport(totalPnt: 115, totalSum: 469.5, totalAvg: 4.08, pnt1: 72, pnt2: 43, pnt3: 0, pnt4: 0, sum1: 304.5, sum2: 165.0, sum3: 0.0, sum4: 0.0, avg1: 4.23, avg2: 3.84, avg3: 0.0, avg4: 0.0, Subjects: [uosF12.Subject(year: 2018, semester: uosF12.Semester.spring, subjectCode: "01110", korName: "화학및실험1", engName: "Chemistry and Experiment I", subjectDiv: uosF12.SubjectDiv.A01, pnt: 4, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(year: 2018, semester: uosF12.Semester.spring, subjectCode: "01429", korName: "일반물리학및실습", engName: "Genaral Physics and Experiment", subjectDiv: uosF12.SubjectDiv.A01, pnt: 4, grade: 4.0, gradeStr: "A0", valid: true, retry: false), uosF12.Subject(year: 2018, semester: uosF12.Semester.spring, subjectCode: "01546", korName: "대학영어(W)", engName: "College English(W)", subjectDiv: uosF12.SubjectDiv.A02, pnt: 2, grade: 3.5, gradeStr: "B+", valid: true, retry: false), uosF12.Subject(year: 2018, semester: uosF12.Semester.spring, subjectCode: "01583", korName: "수학 I", engName: "Calculus I", subjectDiv: uosF12.SubjectDiv.A02, pnt: 3, grade: 3.0, gradeStr: "B0", valid: true, retry: false), uosF12.Subject(year: 2018, semester: uosF12.Semester.spring, subjectCode: "01666", korName: "의사결정과토론", engName: "Decision-making and Discussion", subjectDiv: uosF12.SubjectDiv.A02, pnt: 2, grade: 2.5, gradeStr: "C+", valid: true, retry: false), uosF12.Subject(year: 2018, semester: uosF12.Semester.spring, subjectCode: "71071", korName: "학업설계상담 Ⅰ", engName: "STUDY-PLANNING COUNSELING Ⅰ", subjectDiv: uosF12.SubjectDiv.A03, pnt: 0, grade: 4.5, gradeStr: "S", valid: true, retry: false)])
}

//학기
public enum Semester: String, CaseIterable, Comparable{
    case spring = "1학기"
    case summer = "여름계절수업"
    case fall = "2학기"
    case winter = "겨울계절수업"
    private var sortOrder: Int {
        Semester.allCases.firstIndex(of: self)!
    }
    public static func < (lhs: Semester, rhs: Semester) -> Bool {
        lhs.sortOrder<rhs.sortOrder
    }
}
//교과구분
public enum SubjectDiv: String, CaseIterable, Hashable, Comparable{
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
    private var sortOrder: Int {
        SubjectDiv.allCases.firstIndex(of: self)!
    }
    
    public static func < (lhs: SubjectDiv, rhs: SubjectDiv) -> Bool {
        lhs.sortOrder<rhs.sortOrder
    }
    
}

//과목 성적표
public struct Subject: Identifiable {
    public var id = UUID()
    public var year:Int = 0//학년도
    public var semester:Semester = .spring//학기 enum
    public var subjectCode:String = "00000"//과목번호
    public var korName:String = "과목명"//한글과목명
    public var engName:String = "SubName"//영문과목명
    public var subjectDiv:SubjectDiv = .A01//교과구분 enum
    public var pnt:Int = 1//학점
    public var grade:Float = 1.0//등급
    public var gradeStr:String = "F"//알파벳등급
    public var valid:Bool = false//성적유효여부
    public var retry:Bool = false//재수강여부

    public static let demo = Subject(year:2020, semester:.fall, subjectCode: "12345", korName: "마이크로프로세서및실습", engName: "Microprocessor Design and Experiment", subjectDiv: .A01, pnt:3, grade:4.0, gradeStr:"A0", valid:true, retry:true)
}
