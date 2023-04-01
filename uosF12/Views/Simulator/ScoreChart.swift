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
    @State var string:String = ""
    @Binding var selectedSemester:(x:String?, `all`:Float?, major:Float?)
    var major: [Subject] {
        modelData.scoreReportCopied.Subjects.filter{
            [SubjectDiv.A03,SubjectDiv.A04].contains($0.subjectDiv)
        }
    }
    var chartAllData: [(x: String, y:Float)] {
        ScoreReportHelper.halfGroupedSubjects(subjects: modelData.scoreReportCopied.Subjects).map{ subjects in
        (x:"`\(subjects[0].year-2000)년\n\(subjects[0].semester.Half.rawValue)", y: ScoreReportHelper.averageGrade(subjects))
        } + [(x: "이번\n학기", y:expectedAllAvg)]
    }
    var chartMajorData: [(x: String, y:Float)] {
        ScoreReportHelper.halfGroupedSubjects(subjects: major).map{ subjects in
        (x:"`\(subjects[0].year-2000)년\n\(subjects[0].semester.Half.rawValue)", y: ScoreReportHelper.averageGrade(subjects))
        } + [(x: "이번\n학기", y:expectedMajorAvg)]
    }
    func findElement(location: CGPoint, proxy: ChartProxy, geometry: GeometryProxy, cancelable: Bool){
        let ret = proxy.value(at: location, as:(String,Float).self)
        if cancelable && ret?.0 == selectedSemester.x {
            selectedSemester = (x:nil, all:nil, major:nil)
            return
        }
        let selectedAll:[(x:String, y:Float)] = chartAllData.filter{$0.x == ret?.0}
        let selectedMajor:[(x:String, y:Float)] = chartMajorData.filter{$0.x == ret?.0}
        if !selectedAll.isEmpty || !selectedMajor.isEmpty {
            selectedSemester.x = ret?.0
            selectedSemester.all = selectedAll.isEmpty ? nil : selectedAll[0].y
            selectedSemester.major = selectedMajor.isEmpty ? nil : selectedMajor[0].y
        }
    }
    
    var body: some View {
        Chart{
            ForEach(chartAllData, id:\.x) {x,y in
                MyLineMark(x:x, y:y, div: "전체")
            }
            MyLineMark(x: "이번\n학기", y: expectedAllAvg, div: "전체")
            MyPointMark(x: "이번\n학기", y: expectedAllAvg, div: "전체")
            
            ForEach(chartMajorData, id:\.x) {x,y in
                MyLineMark(x:x, y:y, div: "전공")
            }
            
            MyLineMark(x: "이번\n학기", y: expectedMajorAvg, div: "전공")
            MyPointMark(x: "이번\n학기", y: expectedMajorAvg, div: "전공")
        }
        .chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(
                        SpatialTapGesture()
                            .onEnded { value in
                                // Convert the gesture location to the coordiante space of the plot area.
                                let origin = geometry[proxy.plotAreaFrame].origin
                                let location = CGPoint(
                                    x: value.location.x - origin.x,
                                    y: value.location.y - origin.y
                                )
                                findElement(location: location, proxy: proxy, geometry: geometry, cancelable:true)
                            }
                            .exclusively(
                                before: DragGesture()
                                    .onChanged { value in
                                        // Convert the gesture location to the coordiante space of the plot area.
                                        let origin = geometry[proxy.plotAreaFrame].origin
                                        let location = CGPoint(
                                            x: value.location.x - origin.x,
                                            y: value.location.y - origin.y
                                        )
                                        findElement(location: location, proxy: proxy, geometry: geometry, cancelable: false)
                                    }
                            )
                    )
            }
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
            ScoreChart(expectedAllAvg: .constant(0.0), expectedMajorAvg: .constant(4.5), selectedSemester: .constant((x:nil,all:nil,major:nil)))
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
