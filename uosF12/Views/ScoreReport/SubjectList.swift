//
//  SubjectList.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/21.
//

import SwiftUI

struct SubjectList: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView{
            List{
                VStack{
                    ForEach(modelData.scoreReport.Subjects) { subject in
                        SubjectView(subject:subject)
                    }
                }
            }
            .navigationTitle("성적표")
        }
    }
}

struct SubjectList_Previews: PreviewProvider {
    static var previews: some View {
        SubjectList()
            .environmentObject(ModelData())
    }
}
