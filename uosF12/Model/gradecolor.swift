import SwiftUI

public func gradeColor(_ grade:String) -> Color {
    switch(grade){
    case "A+":
        fallthrough
    case "A0":
        return .green
    case "B+":
        fallthrough
    case "B0":
        return .yellow
    case "C+":
        fallthrough
    case "C0":
        return .orange
    case "D+":
        fallthrough
    case "D0":
        return .red
    case "F":
        return .pink
    case "S":
        return .blue
    default:
        return .primary
    }
}
