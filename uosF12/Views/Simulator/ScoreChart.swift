//
//  ScoreChart.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/26.
//

import SwiftUI
import Charts

extension Character {
    
}

struct ScoreChart: View {
    @EnvironmentObject var modelData:ModelData
    @State private var selected:Int? = nil
    var major: [Subject] {
        modelData.scoreReport.Subjects.filter{
            [SubjectDiv.A03,SubjectDiv.A04,SubjectDiv.A05].contains($0.subjectDiv)
        }
    }
    
    var body: some View {
        Chart{
            ForEach(ScoreReportHelper.halfGroupedSubjects(subjects: modelData.scoreReport.Subjects), id:\.[0].id) {subjects in
                LineMark(
                    x:.value("학기","\(subjects[0].year)년\n\(subjects[0].semester.Half.rawValue)"),
                    y:.value("평점",ScoreReportHelper.averageGrade(subjects))
                )
                .foregroundStyle(by:.value("구분","전체"))
                .symbol(by:.value("구분","전체"))
            }
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: 3))
            .symbolSize(100)
            ForEach(ScoreReportHelper.halfGroupedSubjects(subjects: major), id:\.[0].id) {subjects in
                LineMark(
                    x:.value("학기","\(subjects[0].year)년\n\(subjects[0].semester.Half.rawValue)"),
                    y:.value("평점",ScoreReportHelper.averageGrade(subjects))
                )
                .foregroundStyle(by:.value("구분", "전공"))
                .symbol(by:.value("구분","전공"))
            }
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: 3))
            .symbolSize(100)
        }
        .chartForegroundStyleScale([
            "전공": .blue,
            "전체": .gray
        ])
        .chartSymbolScale([
            "전공":Circle().strokeBorder(lineWidth: 3),
            "전체": Circle().strokeBorder(lineWidth: 3)
        ])
        .chartXAxis {
            AxisMarks(values: .automatic) { _ in 
                AxisValueLabel()
            }
        }
        .chartYAxis{
            AxisMarks(position:.leading,values:[2,3,4])
        }
        .chartYScale(domain: 1.0...5.5)
    }
}

struct ScoreChart_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            ScoreChart()
                .environmentObject(ModelData())
                .padding(.horizontal)
                .frame(height:200)
            Spacer()
        }
    }
}
