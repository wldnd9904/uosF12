//
//  SubjectList.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/21.
//

import SwiftUI


struct SubjectList: View {
    @EnvironmentObject var modelData: ModelData
    @State var sortByGrade:Bool = false
    @State var filterMode:Bool = false
    @State var filterYear:Int? = nil
    @State var filterGrade:String? = nil
    @State var filterDiv:SubjectDiv? = nil
    var filteredSubjects: [Subject] {
        ScoreReportHelper.filteredSubjects(subjects: modelData.scoreReport.Subjects, filterYear: filterYear, filterGrade: filterGrade, filterDiv: filterDiv, sortByGrade: sortByGrade)
    }
    var semesterGroupedSubjects:[[Subject]]{
        ScoreReportHelper.semesterGroupedSubjects(subjects: filteredSubjects)
    }
    var gradeGroupedSubjects:[[Subject]]{
        ScoreReportHelper.gradeGroupedSubjects(subjects: filteredSubjects)
    }

    var body: some View {
        ScrollView{
            VStack{
                Text("전공: \(modelData.scoreReport.pnt1)학점, 평점평균 \(String(modelData.scoreReport.avg1))")
                    .bold()
                Text("교양: \(modelData.scoreReport.pnt2)학점, 평점평균 \(String(modelData.scoreReport.avg2))")
                    .bold()
                if modelData.scoreReport.pnt3>0 {
                    Text("일선: \(modelData.scoreReport.pnt3)학점, 평점평균 \(String(modelData.scoreReport.avg3))")
                        .bold()
                }
                if modelData.scoreReport.pnt4>0 {
                    Text("기타: \(modelData.scoreReport.pnt4)학점, 평점평균 \(String(modelData.scoreReport.avg4))")
                        .bold()
                }
                Text("총계: \(modelData.scoreReport.totalPnt)학점, 평점평균 \(String(modelData.scoreReport.totalAvg))")
                    .bold()
                Divider()
                if sortByGrade {
                    ForEach(gradeGroupedSubjects,id:\.self[0].id){ subjects in
                        Text("\(subjects[0].gradeStr):  \(subjects.count)개, \(ScoreReportHelper.pntSum(subjects))학점")
                            .font(.headline)
                        Divider()
                        ForEach(subjects){ subject in
                            SubjectView(subject:subject)
                            Divider()
                        }
                    }
                } else {
                    ForEach(semesterGroupedSubjects,id:\.self[0].id){ subjects in
                        Text("\(String(subjects[0].year))년  \(subjects[0].semester.rawValue):  \(subjects.count)개, \(ScoreReportHelper.pntSum(subjects))학점 (\(String(format:"%.2f",ScoreReportHelper.averageGrade(subjects))))")
                            .font(.headline)
                        Divider()
                        ForEach(subjects){ subject in
                            SubjectView(subject:subject)
                            Divider()
                        }
                    }
                }
            }
            .padding(.bottom,150)
        }
        .padding()
        .scrollIndicators(.hidden)
        .toolbar {
            Button {
                filterMode.toggle()
            } label: {
                Label("필터", systemImage: "slider.horizontal.3")
            }
        }
        .sheet(isPresented: $filterMode){
            SubjectFilter(sortByGrade: $sortByGrade, filterYear: $filterYear, filterGrade: $filterGrade, filterDiv: $filterDiv)
        }
    }
}


struct SubjectList_Previews: PreviewProvider {
    static var previews: some View {
        SubjectList()
            .environmentObject(ModelData())
    }
}
