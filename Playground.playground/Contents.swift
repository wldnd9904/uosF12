import UIKit
import SwiftUI

Task{
    do{
        print(try await WebFetcher.shared.logInAndGetStudentNo(userID: "wldnd9904", password: "wldnd990428"))
        let (year,semester) = try await WebFetcher.shared.getCurrentYearAndSemester(studNo: "2018920057")
        print(year,semester)
        print(try await WebFetcher.shared.getF12(studNo: "2018920057", year: "2022", semester: "10"))
    } catch {
        print("ㅠ")
    }
}
