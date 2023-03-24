import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

final class ModelData: ObservableObject {
    @Published public var scoreReport:ScoreReport = ScoreReport.demo
    public var studNo:String = ""
    public var gradeList:[String] = []
    public var yearList:[Int] = []
    public var divList:[SubjectDiv] = []
    public var credits:Credits = Credits.demo
    public init(){
        self.scoreReport = ScoreReport.demo
        self.gradeList = scoreReport.Subjects.map{
            $0.gradeStr
        }.removingDuplicates()
        self.yearList = scoreReport.Subjects.map{
            $0.year
        }.removingDuplicates()
        self.divList = scoreReport.Subjects.map{
            $0.subjectDiv
        }.removingDuplicates()
    }
    public func login(userID:String, password:String) async throws {
        self.studNo = try await WebFetcher.shared.logInAndGetStudentNo(userID: userID, password: password)
        let report = try await WebFetcher.shared.getScoreReport(studNo: studNo)
        let credits = try await WebFetcher.shared.getCredits(studNo: studNo)
        DispatchQueue.main.async {[weak self] in
            self?.scoreReport = report
            self?.gradeList = report.Subjects.map{$0.gradeStr}.removingDuplicates().sorted()
            self?.yearList = report.Subjects.map{$0.year}.removingDuplicates().sorted()
            self?.divList = report.Subjects.map{$0.subjectDiv}.removingDuplicates().sorted()
            self?.credits = credits
        }
    }
}
