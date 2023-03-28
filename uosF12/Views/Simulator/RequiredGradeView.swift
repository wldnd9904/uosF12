//
//  RequiredGradeView.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/28.
//

import SwiftUI

struct RequiredGradeView: View {
    @EnvironmentObject var modelData:ModelData
    @State var isMajor:Bool = false
    var body: some View {
        VStack{
            Picker("구분",selection: $isMajor){
                Text("전체").tag(false)
                Text("전공").tag(true)
            }
        }
    }
}

struct RequiredGradeView_Previews: PreviewProvider {
    static var previews: some View {
        RequiredGradeView()
            .environmentObject(ModelData())
    }
}
