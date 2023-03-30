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
    @Binding var expectedAllAvg:Float
    @Binding var expectedMajorAvg:Float
    var major: [Subject] {
        modelData.scoreReportCopied.Subjects.filter{
            [SubjectDiv.A03,SubjectDiv.A04,SubjectDiv.A05].contains($0.subjectDiv)
        }
    }
    
    var body: some View {
        Chart{
            ForEach(ScoreReportHelper.halfGroupedSubjects(subjects: modelData.scoreReportCopied.Subjects), id:\.[0].id) {subjects in
                MyLineMark(x: "`\(subjects[0].year-2000)년\n\(subjects[0].semester.Half.rawValue)", y: ScoreReportHelper.averageGrade(subjects), div: "전체")
            }
            MyLineMark(x: "이번\n학기", y: expectedAllAvg, div: "전체")
            MyPointMark(x: "이번\n학기", y: expectedAllAvg, div: "전체")
            
            ForEach(ScoreReportHelper.halfGroupedSubjects(subjects: major), id:\.[0].id) {subjects in
                MyLineMark(x: "`\(subjects[0].year-2000)년\n\(subjects[0].semester.Half.rawValue)", y: ScoreReportHelper.averageGrade(subjects), div: "전공")
            }
            
            MyLineMark(x: "이번\n학기", y: expectedMajorAvg, div: "전공")
            MyPointMark(x: "이번\n학기", y: expectedMajorAvg, div: "전공")
            
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
        .animation(.spring(), value: expectedAllAvg)
        .animation(.spring(), value: expectedMajorAvg)
        .animation(.spring(), value: modelData.scoreReportCopied.avg(div: ""))
    }
}

struct ScoreChart_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            ScoreChart(expectedAllAvg: .constant(0.0), expectedMajorAvg: .constant(4.5))
                .environmentObject(ModelData())
                .padding(.horizontal)
                .frame(height:200)
            Spacer()
        }
    }
}

struct MyLineMark: ChartContent {
    let x: String
    let y: Float
    let div: String
    var body: some ChartContent {
        LineMark(
            x:.value("학기",x),
            y:.value("평점",y)
        )
        .foregroundStyle(by:.value("구분",div))
        .symbol(by:.value("구분",div))
        .interpolationMethod(.catmullRom)
        .lineStyle(StrokeStyle(lineWidth: 3))
        .symbolSize(100)
    }
}

struct MyPointMark: ChartContent {
    let x: String
    let y: Float
    let div: String
    var body: some ChartContent {
        PointMark(
            x:.value("학기",x),
            y:.value("평점",y)
        )
        .foregroundStyle(.yellow)
        .symbol(by:.value("구분",div))
        .interpolationMethod(.catmullRom)
        .lineStyle(StrokeStyle(lineWidth: 3))
        .symbolSize(100)
    }
}
