//
//  ContentView.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/14.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData:ModelData
    @State private var selectedTab: Tab = .scoreReport
    var body: some View {
        ZStack{
            NavigationStack{
                ZStack{
                    TabView(selection: $selectedTab) {
                        SubjectList()
                            .tag(Tab.scoreReport)
                            .environmentObject(modelData)
                            .navigationTitle("성적표")
                        Text("GD")
                            .tag(Tab.simulator)
                            .navigationTitle("학점 시뮬레이터")
                        Text("GD")
                            .tag(Tab.f12)
                            .navigationTitle("F12")
                        Text("GD")
                            .tag(Tab.credits)
                            .navigationTitle("이수학점조회")
                        Text("GD")
                            .tag(Tab.profile)
                            .navigationTitle("내 정보")
                    }
                    .tabViewStyle(.page)
                    VStack{
                        Spacer()
                        TabBar(selectedTab: $selectedTab)
                    }
                }
            }
            Login()
                .background(.white)
                .opacity(modelData.loggedIn ? 0.0 : 1.0)
                .animation(.spring(), value:modelData.loggedIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
