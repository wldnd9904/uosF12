//
//  F12List.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/30.
//

import SwiftUI

struct F12List: View {
    @EnvironmentObject var modelData:ModelData
    var avg:Float {
        if modelData.f12.items.isEmpty {
            return 0.0
        } else {
            return (modelData.f12.items.reduce(0.0){
                $0 + $1.grade * Float($1.pnt)
            } / Float(modelData.f12.items.reduce(0){
                $0 + $1.pnt
            }))
        }
    }
    var openedNameList:[String] {
        modelData.f12.items.map{$0.name}
    }
    var hiddenRegistration:[Registration]{
        modelData.registrations.filter{
            !openedNameList.contains($0.name)
        }
    }
    var body: some View {
        ScrollView {
            Text("전체 학점: \(modelData.f12.totalSum)학점 (\(String(format:"%.2f",modelData.f12.avg)))")
                .bold()
            Text("공개된 학점: \(modelData.f12.currentSum)학점 (\(String(format:"%.2f",avg)))")
                .bold()
            Divider()
            ForEach(modelData.f12.items, id:\.name){ item in
                F12ItemView(item: item)
                    .padding(.horizontal)
                Divider()
            }
            ForEach(hiddenRegistration, id:\.name) { registration in
                F12ItemView(item:F12Item(name:registration.name, pnt:registration.pnt, gradeStr: "비공개"))
                    .padding(.horizontal)
                Divider()
            }
        }
    }
}

struct F12List_Previews: PreviewProvider {
    static var previews: some View {
        F12List()
            .environmentObject(ModelData())
    }
}
