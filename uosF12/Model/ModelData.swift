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
    @Published public var scoreReport:ScoreReport = ScoreReport()
    public var studNo:String = ""
    public var gradeList:[String] = []
    public var yearList:[Int] = []
    public var divList:[SubjectDiv] = []
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
        DispatchQueue.main.async {[weak self] in
            self?.scoreReport = report
            self?.gradeList = report.Subjects.map{$0.gradeStr}.removingDuplicates().sorted()
            self?.yearList = report.Subjects.map{$0.year}.removingDuplicates().sorted()
            self?.divList = report.Subjects.map{$0.subjectDiv}.removingDuplicates().sorted()
        }
    }
    /*public func login(userID:String, password:String){
        WebFetcher.shared.login(portalID:PortalID(userID: userID, password: password)){ result in
            switch result{
            case .success(_):
                WebFetcher.shared.getScoreReport(completion:{ result in
                    switch result{
                    case .success(let report):
                        DispatchQueue.main.async {[weak self] in
                            self?.scoreReport = report
                            self?.gradeList = report.Subjects.map{
                                $0.gradeStr
                            }.removingDuplicates().sorted()
                            self?.yearList = report.Subjects.map{
                                $0.year
                            }.removingDuplicates().sorted()
                            self?.divList = report.Subjects.map{
                                $0.subjectDiv
                            }.removingDuplicates().sorted()
                            self?.loggedIn = true
                            self?.loggingIn = false
                        }
                    case .failure(let err):
                        print(err)
                        self.loggingIn = false
                    }
                    
                })
            case .failure(let err):
                print(err)
                self.loggingIn = false
            }
        }
    }*/
}
