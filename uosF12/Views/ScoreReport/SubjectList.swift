//
//  SubjectList.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/21.
//

import SwiftUI


struct SubjectList: View {
    @EnvironmentObject var modelData: ModelData
    @State var filterMode:Bool = false
    @State var filterYear:Int? = nil
    @State var filterGrade:String? = nil
    @State var filterDiv:SubjectDiv? = nil
    var filteredSubjects:[Subject] {
        modelData.scoreReport.Subjects.filter{ subject in
            ((filterYear == nil)||subject.year==filterYear) && ((filterGrade == nil)||subject.gradeStr==filterGrade) && ((filterDiv == nil)||subject.subjectDiv==filterDiv)
           }
       }
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(filteredSubjects) { subject in
                        SubjectView(subject:subject)
                    }
                }
            }.padding()
            .navigationTitle("성적표")
            .toolbar {
                Button {
                    filterMode.toggle()
                } label: {
                    Label("User Profilie", systemImage: "slider.horizontal.3")
                }
                .sheet(isPresented: $filterMode){
                    List {
                        Text("필터").bold()
                        Picker("수강년도", selection: $filterYear) {
                            Text("선택안함").tag(nil as Int?)
                            ForEach(modelData.yearList, id:\.self){ year in
                                Text(String(year))
                                    .tag(year as Int?)
                            }
                        }
                        Picker("학점", selection: $filterGrade) {
                            Text("선택안함").tag(nil as String?)
                            ForEach(modelData.gradeList, id:\.self){ grade in
                                Text(grade)
                                    .tag(grade as String?)
                            }
                        }
                        Picker("구분", selection: $filterDiv) {
                            Text("선택안함").tag(nil as SubjectDiv?)
                            ForEach(modelData.divList, id:\.self){ div in
                                Text(div.rawValue)
                                    .tag(div as SubjectDiv?)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SubjectList_Previews: PreviewProvider {
    static var previews: some View {
        SubjectList()
            .environmentObject(ModelData())
    }
}
