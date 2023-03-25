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
    
    public static let demo = ScoreReport(totalPnt: 115, totalSum: 469.5, totalAvg: 4.08, pnt1: 72, pnt2: 43, pnt3: 0, pnt4: 0, sum1: 304.5, sum2: 165.0, sum3: 0.0, sum4: 0.0, avg1: 4.23, avg2: 3.84, avg3: 0.0, avg4: 0.0, Subjects: [uosF12.Subject(    year: 2018, semester: uosF12.Semester.spring, subjectCode: "01110", korName: "화학및실험1", engName: "Chemistry and Experiment I", subjectDiv: uosF12.SubjectDiv.A01, pnt: 4, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.spring, subjectCode: "01429", korName: "일반물리학및실습", engName: "Genaral Physics and Experiment", subjectDiv: uosF12.SubjectDiv.A01, pnt: 4, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.spring, subjectCode: "01546", korName: "대학영어(W)", engName: "College English(W)", subjectDiv: uosF12.SubjectDiv.A02, pnt: 2, grade: 4.0, gradeStr: "A0", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.spring, subjectCode: "01583", korName: "수학 I", engName: "Calculus I", subjectDiv: uosF12.SubjectDiv.A02, pnt: 3, grade: 3.5, gradeStr: "B+", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.spring, subjectCode: "01666", korName: "의사결정과토론", engName: "Decision-making and Discussion", subjectDiv: uosF12.SubjectDiv.A02, pnt: 2, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.spring, subjectCode: "71071", korName: "학업설계상담 Ⅰ", engName: "STUDY-PLANNING COUNSELING Ⅰ", subjectDiv: uosF12.SubjectDiv.A03, pnt: 0, grade: 4.5, gradeStr: "S", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.spring, subjectCode: "71073", korName: "컴퓨터개론", engName: "Introduction to Digital Computer", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.fall, subjectCode: "01111", korName: "화학및실험2", engName: "Chemistry and Experiment II", subjectDiv: uosF12.SubjectDiv.A01, pnt: 4, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.fall, subjectCode: "01397", korName: "공학도의창업과경영", engName: "Establishment and Business for Engineers", subjectDiv: uosF12.SubjectDiv.A01, pnt: 2, grade: 3.0, gradeStr: "B0", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.fall, subjectCode: "01545", korName: "대학영어(S)", engName: "College English(S)", subjectDiv: uosF12.SubjectDiv.A02, pnt: 2, grade: 3.0, gradeStr: "B0", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.fall, subjectCode: "01584", korName: "수학 II", engName: "Calculus II", subjectDiv: uosF12.SubjectDiv.A02, pnt: 3, grade: 3.5, gradeStr: "B+", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.fall, subjectCode: "01665", korName: "과학기술글쓰기", engName: "Technical Writing For Science And Technology", subjectDiv: uosF12.SubjectDiv.A02, pnt: 2, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.fall, subjectCode: "30000", korName: "창의공학기초설계", engName: "Introduction to Creative Engineering Design", subjectDiv: uosF12.SubjectDiv.A03, pnt: 3, grade: 3.5, gradeStr: "B+", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.fall, subjectCode: "71002", korName: "C언어및실습", engName: "C Programming  Language", subjectDiv: uosF12.SubjectDiv.A03, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2018, semester: uosF12.Semester.fall, subjectCode: "71072", korName: "학업설계상담 Ⅱ", engName: "STUDY-PLANNING COUNSELING Ⅱ", subjectDiv: uosF12.SubjectDiv.A03, pnt: 0, grade: 4.5, gradeStr: "S", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.spring, subjectCode: "01407", korName: "공학기술과사회", engName: "Engineering Technology and Society", subjectDiv: uosF12.SubjectDiv.A01, pnt: 2, grade: 3.5, gradeStr: "B+", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.spring, subjectCode: "71006", korName: "객체지향프로그래밍및실습", engName: "Object-Oriented Programming", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.spring, subjectCode: "71007", korName: "선형대수", engName: "Linear Algebra", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 3.5, gradeStr: "B+", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.spring, subjectCode: "71008", korName: "이산수학", engName: "Discrete Mathematics", subjectDiv: uosF12.SubjectDiv.A03, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.spring, subjectCode: "71042", korName: "확률과통계", engName: "Probability and Statistics", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.0, gradeStr: "A0", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.spring, subjectCode: "71078", korName: "논리회로및실습", engName: "Digital Logic Design and Experiment", subjectDiv: uosF12.SubjectDiv.A03, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.fall, subjectCode: "01536", korName: "인간우주그리고문명", engName: "Man, Universe and Civilization", subjectDiv: uosF12.SubjectDiv.A01, pnt: 3, grade: 3.5, gradeStr: "B+", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.fall, subjectCode: "01702", korName: "인간과인공지능", engName: "Human being and Artificial Intelligence", subjectDiv: uosF12.SubjectDiv.A01, pnt: 3, grade: 3.0, gradeStr: "B0", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.fall, subjectCode: "71005", korName: "프로그래밍언어론", engName: "Programming Language", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.0, gradeStr: "A0", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.fall, subjectCode: "71051", korName: "수리모형과미분방정식", engName: "Mathematical Models for Engineering Problems and Different Equation", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 3.5, gradeStr: "B+", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.fall, subjectCode: "71067", korName: "유닉스프로그래밍", engName: "Unix Programming", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2019, semester: uosF12.Semester.fall, subjectCode: "71074", korName: "자료구조", engName: "Data Structure", subjectDiv: uosF12.SubjectDiv.A03, pnt: 3, grade: 4.0, gradeStr: "A0", valid: true, retry: false), uosF12.Subject(    year: 2020, semester: uosF12.Semester.winter, subjectCode: "94443", korName: "생활속의심리학", engName: "Psychology in Our Life", subjectDiv: uosF12.SubjectDiv.A01, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.spring, subjectCode: "71015", korName: "운영체제", engName: "Operating System", subjectDiv: uosF12.SubjectDiv.A03, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.spring, subjectCode: "71021", korName: "컴퓨터통신", engName: "Computer Communication", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.spring, subjectCode: "71028", korName: "컴퓨터보안", engName: "Computer Security", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.0, gradeStr: "A0", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.spring, subjectCode: "71039", korName: "컴퓨터알고리즘", engName: "Computer Algorithms", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.0, gradeStr: "A0", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.spring, subjectCode: "71068", korName: "윈도우즈프로그래밍", engName: "Windows Programming", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.spring, subjectCode: "71079", korName: "컴퓨터구조론", engName: "Computer Architecture", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.summer, subjectCode: "01396", korName: "공학적글쓰기와의사소통", engName: "Technical Writing and Communication", subjectDiv: uosF12.SubjectDiv.A01, pnt: 2, grade: 3.0, gradeStr: "B0", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.fall, subjectCode: "01565", korName: "과학기술과지식재산", engName: "Science Technology and Intellectual Property", subjectDiv: uosF12.SubjectDiv.A01, pnt: 2, grade: 3.0, gradeStr: "B0", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.fall, subjectCode: "71016", korName: "데이터통신", engName: "Data Communication", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.0, gradeStr: "A0", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.fall, subjectCode: "71019", korName: "데이터베이스", engName: "Database System", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.fall, subjectCode: "71032", korName: "소프트웨어공학", engName: "Software Engineering", subjectDiv: uosF12.SubjectDiv.A03, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.fall, subjectCode: "71049", korName: "임베디드시스템설계", engName: "Embedded Systems Design", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.0, gradeStr: "A0", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.fall, subjectCode: "71075", korName: "네트워크보안", engName: "Network Security", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false), uosF12.Subject(    year: 2022, semester: uosF12.Semester.fall, subjectCode: "71076", korName: "마이크로프로세서설계및실습", engName: "Microprocessor Design and Experiment", subjectDiv: uosF12.SubjectDiv.A04, pnt: 3, grade: 4.5, gradeStr: "A+", valid: true, retry: false)])

}

//학기
public enum Semester: String, CaseIterable, Comparable{
    case spring = "1학기"
    case summer = "여름계절수업"
    case fall = "2학기"
    case winter = "겨울계절수업"
    var Half: Semester {
        switch(self){
        case .spring:
            fallthrough
        case .summer:
            return .spring
        case .fall:
            fallthrough
        case .winter:
            return .fall
        }
    }
    var sortOrder: Int {
        switch(self){
            case .spring:  return 1
            case .summer:  return 2
            case .fall:  return 3
            case .winter:  return 4
        }
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
