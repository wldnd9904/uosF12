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
    @State private var loggedIn:Bool = false
    var body: some View {
        ZStack{
            if loggedIn {
                NavigationStack{
                    ZStack{
                        TabView(selection: $selectedTab) {
                            SubjectList()
                                .tag(Tab.scoreReport)
                            SimulatorView()
                                .tag(Tab.simulator)
                            Text("TODO")
                                .tag(Tab.f12)
                            CreditList()
                                .tag(Tab.credits)
                            SettingsView(loggedIn: $loggedIn)
                                .tag(Tab.settings)
                        }
                        .tabViewStyle(.page)
                        VStack{
                            Spacer()
                            TabBar(selectedTab: $selectedTab)
                        }
                    }
                    .navigationTitle(selectedTab.name)
                    .navigationBarTitleDisplayMode(.inline)
                }
                .onAppear{
                    selectedTab = .scoreReport
                }
            }
            LoginView(loggedIn: $loggedIn)
                .background(.background)
                .opacity(loggedIn ? 0.0 : 1.0)
                .animation(.spring(), value:loggedIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
