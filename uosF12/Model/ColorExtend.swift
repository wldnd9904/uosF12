import SwiftUI

func gradeColor(_ grade:String) -> Color {
    switch(grade){
    case "A+":
        fallthrough
    case "S":
        fallthrough
    case "A0":
        return .green
    case "B+":
        fallthrough
    case "B0":
        return .orange
    case "C+":
        fallthrough
    case "C0":
        return .yellow
    case "D+":
        fallthrough
    case "D0":
        return .red
    case "F":
        return .pink
    default:
        return .black
    }
}
