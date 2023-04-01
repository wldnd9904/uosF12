import Foundation
import SwiftUI

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

struct userData: Codable {
    var userID: String = ""
    private var _colorSchemeSetting: Int = 0
    var colorSchemeSetting:Int {
        get {
            withAnimation{
                return _colorSchemeSetting
            }
        }
        set {
            withAnimation{
                _colorSchemeSetting = newValue
            }
        }
    }
}


final class ModelData: ObservableObject {
    @Published public var scoreReport:ScoreReport = ScoreReport.demo
    @Published public var scoreReportCopied:ScoreReport = ScoreReport.demo
    @Published var saved:userData = userData()
    @Published var f12:F12 = F12()
    public var f12able:Bool = true
    public var studNo:String = ""
    public var year:String = ""
    public var semester:String = ""
    public var gradeList:[String] = []
    public var yearList:[Int] = []
    public var divList:[SubjectDiv] = []
    public var credits:Credits = Credits.demo
    public var registrations:[Registration] = [Registration.demo, Registration.demo2]
    public init(){
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode(userData.self, from: data) {
                self.saved = decoded
                return
            }
        } else {
            self.saved = userData()
        }
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
        (self.year, self.semester) = try await WebFetcher.shared.getCurrentYearAndSemester(studNo: studNo)
        let registrations = try await WebFetcher.shared.getRegistration(studNo: studNo, year: year, semester: semester)
        let f12able = try await WebFetcher.shared.getF12Availability()
        //let f12able = true
        let f12 = try await WebFetcher.shared.getF12(studNo: studNo, year: year, semester: semester)
        //let f12 = F12.demo
        DispatchQueue.main.async {[weak self] in
            self?.scoreReport = report
            self?.scoreReportCopied = report
            self?.gradeList = report.Subjects.map{$0.gradeStr}.removingDuplicates().sorted()
            self?.yearList = report.Subjects.map{$0.year}.removingDuplicates().sorted()
            self?.divList = report.Subjects.map{$0.subjectDiv}.removingDuplicates().sorted()
            self?.credits = credits
            self?.registrations = registrations
            self?.f12able = f12able
            self?.f12 = f12
        }
    }
    
    public func logout() async throws{
        try await WebFetcher.shared.logout()
        DispatchQueue.main.async {[weak self] in
            self?.studNo = ""
            self?.scoreReport = ScoreReport.demo
            self?.gradeList = []
            self?.yearList = []
            self?.divList = []
            self?.credits = Credits.demo
            self?.registrations = [Registration.demo, Registration.demo2]
        }
    }
    
    public func f12Refresh() async throws {
        let f12 = try await WebFetcher.shared.getF12(studNo: studNo, year: year, semester: semester)
        //let f12 = F12.demo
        DispatchQueue.main.async {[weak self] in
            self?.f12 = f12
        }
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(saved) {
            UserDefaults.standard.set(encoded, forKey: "SavedData")
        }
    }
    
    var colorScheme:ColorScheme? {
        switch(saved.colorSchemeSetting){
        case 1:
            return .light
        case 2:
            return .dark
        default:
            return nil
        }
    }
}
