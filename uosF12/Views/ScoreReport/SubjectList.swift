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
    @Binding var filterMode:Bool
    @State var filterYear:Int? = nil
    @State var filterGrade:String? = nil
    @State var filterDiv:SubjectDiv? = nil
    var filteredSubjects:[Subject] {
        modelData.scoreReport.Subjects.filter{ subject in
            ((filterYear == nil)||subject.year==filterYear) && ((filterGrade == nil)||subject.gradeStr==filterGrade) && ((filterDiv == nil)||subject.subjectDiv==filterDiv)
        }.sorted{
            sortByGrade ? $0.grade > $1.grade : (($0.year, $0.semester) < ($1.year, $1.semester))
        }
    }
    var semesterGroupedSubjects:[[Subject]]{
        Dictionary(grouping:filteredSubjects){
            "\($0.year)\($0.semester.sortOrder)"
        }.sorted{$0.0<$1.0}.map{$0.1.sorted{$0.grade>$1.grade}}
    }
    var gradeGroupedSubjects:[[Subject]]{
        Dictionary(grouping:filteredSubjects){
            $0.gradeStr
        }.sorted{$0.0<$1.0}.map{$0.1.sorted{$0.year<$1.year}}
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
                        Text("\(subjects[0].gradeStr):  \(subjects.count)개, \(subjects.reduce(0){$0+$1.pnt})학점")
                            .font(.headline)
                        Divider()
                        ForEach(subjects){ subject in
                            SubjectView(subject:subject)
                            Divider()
                        }
                    }
                } else {
                    ForEach(semesterGroupedSubjects,id:\.self[0].id){ subjects in
                        Text("\(String(subjects[0].year))년  \(subjects[0].semester.rawValue):  \(subjects.count)개, \(subjects.reduce(0){$0+$1.pnt})학점")
                            .font(.headline)
                        Divider()
                        ForEach(subjects){ subject in
                            SubjectView(subject:subject)
                            Divider()
                        }
                    }
                }
            }
            .padding(.bottom,200)
        }
        .padding()
        .sheet(isPresented: $filterMode){
            List {
                Text("정렬").bold()
                    .listRowSeparator(.hidden)
                Picker("정렬", selection: $sortByGrade) {
                    Text("년도순").tag(false)
                    Text("성적순").tag(true)
                }
                .pickerStyle(.segmented)
                .listRowSeparator(.hidden)
                Text("필터").bold()
                    .listRowSeparator(.hidden)
                Picker("수강년도", selection: $filterYear) {
                    Text("선택안함").tag(nil as Int?)
                    ForEach(modelData.yearList, id:\.self){ year in
                        Text(String(year))
                            .tag(year as Int?)
                    }
                }
                .listRowSeparator(.hidden)
                Picker("학점", selection: $filterGrade) {
                    Text("선택안함").tag(nil as String?)
                    ForEach(modelData.gradeList, id:\.self){ grade in
                        Text(grade)
                            .tag(grade as String?)
                    }
                }
                .listRowSeparator(.hidden)
                Picker("구분", selection: $filterDiv) {
                    Text("선택안함").tag(nil as SubjectDiv?)
                    ForEach(modelData.divList, id:\.self){ div in
                        Text(div.rawValue)
                            .tag(div as SubjectDiv?)
                    }
                }
                .listRowSeparator(.hidden)
            }
            .padding()
            .listStyle(.inset)
            .presentationDetents([.fraction(0.45)])
            .presentationDragIndicator(.visible)
        }
    }
}


struct SubjectList_Previews: PreviewProvider {
    static var previews: some View {
        SubjectList(filterMode: .constant(true))
            .environmentObject(ModelData())
    }
}
