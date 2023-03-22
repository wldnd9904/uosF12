import UIKit
import SwiftUI

let modelData=ModelData()
print(Dictionary(grouping: modelData.scoreReport.Subjects){$0.semester.rawValue}.sorted{$0.0<$1.0}.map{$0.1.sorted{$0.grade>$1.grade}})

