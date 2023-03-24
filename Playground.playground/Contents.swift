import UIKit
import SwiftUI
func printCredit(credit: CreditItem){
    if credit.child.isEmpty {
        print("\(credit.name): \(credit.cnt)개, (\(credit.pnt)/\(credit.min))")
    } else {
        print("===\(credit.name): \(credit.cnt)개, (\(credit.pnt)/\(credit.min))====")
        for chil in credit.child {
            printCredit(credit: chil)
        }
        print("==============================")
    }
}
Task {
    print(try await WebFetcher.shared.logInAndGetStudentNo(userID: "wldnd9904", password: "wldnd990428"))
    let credit = try await WebFetcher.shared.getCredits(studNo: "2018920057")
    printCredit(credit:credit.major)
    printCredit(credit:credit.GE)
    print("기타: ")
    for i in credit.etc {
        printCredit(credit: i)
    }
}
    
