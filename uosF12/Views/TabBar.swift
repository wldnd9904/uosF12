//
//  CustomTabBar.swift
//  TestProject0105
//
//  Created by Federico on 01/05/2022.
//
import SwiftUI

enum Tab: String, CaseIterable {
    case scoreReport = "list.dash"
    case simulator = "atom"
    case f12 = "textformat.12"
    case credits = "list.bullet.clipboard"
    case settings = "gearshape"
    var name:String {
        switch(self){
        case .credits:
            return "이수학점조회"
        case .scoreReport:
            return "성적표"
        case .simulator:
            return "학점 실험실"
        case .f12:
            return "F12"
        case .settings:
            return "설정"
        }
    }
}

struct TabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.3 : 1.1)
                        .foregroundColor(tab == selectedTab ? .blue : .gray)
                        .font(.system(size: 20))
                        .padding()
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            .cornerRadius(20)
            .padding(.horizontal)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            Spacer()
            TabBar(selectedTab: .constant(.scoreReport))
        }
    }
}
