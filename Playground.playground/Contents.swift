import UIKit
import SwiftUI
let modelData = ModelData()
print(ScoreReportHelper.halfGroupedSubjects(subjects: modelData.scoreReport.Subjects).map{($0[0].year,$0[0].semester)})
