//
//  SimulatorView.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/26.
//

import SwiftUI

struct SimulatorView: View {
    @EnvironmentObject var modelData:ModelData
    @State private var simulatorMode:Bool = true
    
    var body: some View {
        VStack{
            ScoreChart()
                .frame(height:200)
                .padding(.horizontal)
            Picker("모드", selection: $simulatorMode) {
                Text("학점 예측하기").tag(false)
                Text("필요학점 계산하기").tag(true)
            }
            .pickerStyle(.segmented)
            Spacer()
        }
    }
}

struct SimulatorView_Previews: PreviewProvider {
    static var previews: some View {
        SimulatorView()
            .environmentObject(ModelData())
    }
}
