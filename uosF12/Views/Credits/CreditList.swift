//
//  CreditList.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/24.
//

import SwiftUI

struct CreditList: View {
    @EnvironmentObject var modelData: ModelData
    var body: some View {
        ScrollView{
            VStack{
                Text("졸업이수학점: \(modelData.credits.cnt)개, \(modelData.credits.pnt)/\(modelData.credits.min)학점")
                    .font(.headline)
                CreditView(credit: modelData.credits.major)
                CreditView(credit: modelData.credits.GE)
                ForEach(modelData.credits.etc, id: \.name){ credit in
                    if(credit.cnt>0){
                        CreditView(credit: credit)
                    }
                }
            }
            .padding(.bottom,200)
        }
        .padding()
    }
}

struct CreditList_Previews: PreviewProvider {
    static var previews: some View {
        CreditList()
            .environmentObject(ModelData())
    }
}
