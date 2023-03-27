//
//  SimulatorView.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/26.
//

import SwiftUI

struct SimulatorView: View {
    @EnvironmentObject var modelData:ModelData
    @State private var simulatorMode:Bool = false
    @State private var grades:[Float] = [4.5,4.5,4.5,4.5,4.5,4.5,4.5,4.5,4.5,4.5]
    @State private var isPasses:[Bool] = [false,false,false,false,false,false,false,false,false,false]
    private func pntSum(isOnlyMajor:Bool) -> Int {
        Array(modelData.registrations.enumerated()).reduce(0){
            $0 + ((!isOnlyMajor || isOnlyMajor == $1.element.isMajor) ? $1.element.pnt : 0)
        }
    }
    private func nonPassPntSum(isOnlyMajor:Bool) -> Int {
        Array(modelData.registrations.enumerated()).reduce(0){
            $0 + (((!isOnlyMajor || isOnlyMajor == $1.element.isMajor) && !isPasses[$1.offset]) ? $1.element.pnt : 0)
        }
    }
    private func expectedAvg(isOnlyMajor:Bool) -> Float {
        if(nonPassPntSum(isOnlyMajor: isOnlyMajor)==0) {
            return modelData.scoreReport.avg(div: isOnlyMajor ? "전공" : "")
        } else {
            return Array(modelData.registrations.enumerated()).reduce(0.0){
                $0 + (((!isOnlyMajor || isOnlyMajor == $1.element.isMajor) && !isPasses[$1.offset]) ? (Float($1.element.pnt) * grades[$1.offset]) : 0)
            } / Float(nonPassPntSum(isOnlyMajor: isOnlyMajor))
        }
    }
    private func expectedOverallSum(isOnlyMajor:Bool) -> Int {
        return pntSum(isOnlyMajor: isOnlyMajor) + modelData.scoreReport.sum(div: isOnlyMajor ? "전공" : "")
    }
    private func expectedOverallNonPassSum(isOnlyMajor:Bool) -> Int {
        return nonPassPntSum(isOnlyMajor: isOnlyMajor) + modelData.scoreReport.nonPassSum(div: isOnlyMajor ? "전공" : "")
    }
    private func expectedOverallAvg(isOnlyMajor:Bool) -> Float {
        return ((expectedAvg(isOnlyMajor: isOnlyMajor) * Float(nonPassPntSum(isOnlyMajor: isOnlyMajor))) + (modelData.scoreReport.avg(div: isOnlyMajor ? "전공" : "") * Float(modelData.scoreReport.nonPassSum(div: isOnlyMajor ? "전공" : "")))) / Float(expectedOverallNonPassSum(isOnlyMajor: isOnlyMajor))
    }

    var body: some View {
        VStack{
            ScoreChart(expectedAllAvg: .constant(expectedAvg(isOnlyMajor: false)), expectedMajorAvg: .constant(expectedAvg(isOnlyMajor: true)))
                .frame(height:200)
                .padding(.horizontal)
            Picker("모드", selection: $simulatorMode) {
                Text("학점 예측하기").tag(false)
                Text("필요학점 계산하기").tag(true)
            }
            .pickerStyle(.segmented)
            if !simulatorMode {
                    VStack{
                        Text("전체: \(expectedOverallSum(isOnlyMajor:false))학점 (\(String(format:"%.2f",expectedOverallAvg(isOnlyMajor: false)))) 이번학기: \(pntSum(isOnlyMajor:false))학점 (\(String(format:"%.2f",expectedAvg(isOnlyMajor:false))))")
                            .bold()
                        Text("전공: \(expectedOverallSum(isOnlyMajor:true))학점 (\(String(format:"%.2f",expectedOverallAvg(isOnlyMajor: true)))) 이번학기: \(pntSum(isOnlyMajor:true))학점 (\(String(format:"%.2f",expectedAvg(isOnlyMajor:true))))")
                            .bold()
                        Divider()
                        if(modelData.registrations.isEmpty){
                            Text("수강신청한 과목이 없습니다.")
                        } else {
                            ScrollView{
                                ForEach(Array(modelData.registrations.enumerated()), id:\.offset) { index, item in
                                    RegistrationView(registration: item, grade: $grades[index], ispass: $isPasses[index])
                                }
                            }
                            .scrollIndicators(.hidden)
                        }
                    }.padding()
            }
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
