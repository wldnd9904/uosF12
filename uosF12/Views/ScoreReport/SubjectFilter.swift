//
//  SubjectFilter.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/25.
//

import SwiftUI

struct SubjectFilter: View {
    @EnvironmentObject var modelData:ModelData
    @Binding var sortByGrade: Bool
    @Binding var filterYear:Int?
    @Binding var filterGrade:String?
    @Binding var filterDiv:SubjectDiv?
    
    var body: some View {
        VStack{
            List {
                Text("정렬")
                    .bold()
                    .listRowSeparator(.hidden)
                Picker("정렬", selection: $sortByGrade) {
                    Text("연도순").tag(false)
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

struct SubjectFilter_Previews: PreviewProvider {
    static var previews: some View {
        SubjectFilter(sortByGrade: .constant(false), filterYear: .constant(nil), filterGrade: .constant(nil), filterDiv: .constant(nil))
            .environmentObject(ModelData())
    }
}
