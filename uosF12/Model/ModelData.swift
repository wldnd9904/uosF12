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
    @Published var scoreReport:ScoreReport = ScoreReport()
    @Published var portalID:PortalID = PortalID.blank
    public var gradeList:[String] = []
    public var yearList:[Int] = []
    public var divList:[SubjectDiv] = []
    public init(){
        self.scoreReport = ScoreReport.demo
        self.gradeList = scoreReport.Subjects.map{
            $0.gradeStr
        }.removingDuplicates()
        print(self.gradeList)
        self.yearList = scoreReport.Subjects.map{
            $0.year
        }.removingDuplicates()
        self.divList = scoreReport.Subjects.map{
            $0.subjectDiv
        }.removingDuplicates()
    }
    public func login(){
        WebFetcher.shared.login(portalID:PortalID(userID: "wldnd9904", password: "wldnd990428")){ result in
            switch result{
            case .success(_):
                WebFetcher.shared.getScoreReport(completion:{ result in
                    switch result{
                    case .success(let report):
                        self.scoreReport = report
                        self.gradeList = report.Subjects.map{
                            $0.gradeStr
                        }.removingDuplicates().sorted()
                        print(self.gradeList)
                        self.yearList = report.Subjects.map{
                            $0.year
                        }.removingDuplicates().sorted()
                        self.divList = report.Subjects.map{
                            $0.subjectDiv
                        }.removingDuplicates().sorted()
                    case .failure(let err):
                        print(err)
                    }
                    
                })
            case .failure(let err):
                print(err)
            }
        }
    }
}
