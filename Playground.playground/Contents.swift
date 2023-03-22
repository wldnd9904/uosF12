import UIKit
import SwiftUI
print(SubjectDiv.allCases)

WebFetcher.shared.login(portalID:PortalID(userID: "wldnd9904", password: "wldnd990428")){ result in
    switch result{
    case .success(_):
        WebFetcher.shared.getScoreReport(completion:{
            print($0)
        })
    case .failure(let err):
        print(err)
    }
}
