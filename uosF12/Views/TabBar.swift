//
//  CustomTabBar.swift
//  TestProject0105
//
//  Created by Federico on 01/05/2022.
//
import SwiftUI

enum Tab: String, CaseIterable {
    case scoreReport = "list.dash"
    case simulator = "questionmark.bubble"
    case f12 = "12.lane"
    case credits = "list.bullet.clipboard"
    case profile = "person"
}

struct TabBar: View {
    @Binding var selectedTab: Tab
    private var fillImage: String {
        selectedTab.rawValue
    }
    
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
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
