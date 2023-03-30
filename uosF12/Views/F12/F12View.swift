//
//  F12View.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/30.
//

import SwiftUI

struct F12View: View {
    @EnvironmentObject var modelData:ModelData
    @State var errorMessage:String = ""
    @State var lastTime:Date?
    @State var timeLeft: Int = 10
    @State var timer:Timer?
    func refresh() async {
        do {
            try await modelData.f12Refresh()
        } catch {
            switch(error) {
            case WiseError.sessionExpired:
                errorMessage = "세션이 만료되었습니다. 다시 로그인해야 합니다."
                timer = nil
                lastTime = nil
            default:
                errorMessage = "알 수 없는 오류가 발생했습니다."
                timer = nil
                lastTime = nil
            }
        }
    }
    
    func refreshAction() {
        withAnimation{
            lastTime = Date()
            timeLeft = 60
            Task{await refresh()}
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                timeLeft -= 1
                if timeLeft < 1 {
                    lastTime = Date()
                    timeLeft = 60
                    Task{ await refresh()}
                }
            }
        }
    }
    
    var body: some View {
        if !modelData.f12able {
                Text("성적조회 기간이 아닙니다.")
        } else {
            VStack{
                if errorMessage != "" {
                    Text(errorMessage)
                        .foregroundColor(.red)
                    Button("로그아웃"){
                        Task {try await modelData.logout()}
                    }
                } else {
                    if modelData.f12.items.isEmpty {
                        HStack{
                            Text("공개된 성적이 없습니다.")
                            if errorMessage == "" {
                                RefreshButton(action: refreshAction)
                            }
                        }
                    }
                    VStack{
                        if lastTime != nil {
                            Text("최근 새로고침: \(lastTime!.formatted())")
                        }
                        if timer != nil {
                            Text("\(timeLeft)초 뒤 새로고침됩니다.")
                            Button("새로고침 중단"){
                                withAnimation{
                                    timer?.invalidate()
                                    timer = nil
                                }
                            }
                            .disabled(timeLeft>50)
                        }
                    }
                    .padding(10)
                }
                if !modelData.f12.items.isEmpty{
                    VStack{
                        if errorMessage == "" && timer == nil {
                            RefreshButton(action: refreshAction)
                        }
                        F12List()
                    }
                }
            }
        }
    }
}

struct RefreshButton: View {
    let action:()->()
    
    var body: some View {
        Button(action: action){
            Label("Refresh", systemImage: "arrow.triangle.2.circlepath.circle")
                .labelStyle(.iconOnly)
                .imageScale(.large)
                .padding(10)
        }
    }
}

struct F12View_Previews: PreviewProvider {
    static var previews: some View {
        F12View()
            .environmentObject(ModelData())
    }
}
