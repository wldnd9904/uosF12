import Foundation

final class ModelData: ObservableObject {
    @Published var scoreReport:ScoreReport = ScoreReport()
    @Published var portalID:PortalID = PortalID.blank
    
    public init(){
        WebFetcher.shared.login(portalID:PortalID(userID: "wldnd9904", password: "wldnd990428")){ result in
            switch result{
            case .success(_):
                WebFetcher.shared.getScoreReport(completion:{ result in
                    switch result{
                    case .success(let report):
                        self.scoreReport = report
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
