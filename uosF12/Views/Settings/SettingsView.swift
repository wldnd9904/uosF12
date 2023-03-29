//
//  SettingsView.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/29.
//
import StoreKit
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var modelData:ModelData
    @Binding var loggedIn:Bool
    @Environment(\.requestReview) var requestReview
    
    func logoutAction() {
        loggedIn = false
        Task {
            do {
                try await modelData.logout()
            } catch {
                loggedIn = true
            }
        }
    }
    
    var body: some View {
        List{
            Picker("테마", selection: $modelData.saved.colorSchemeSetting){
                Text("시스템 설정에 맞춤").tag(0)
                Text("라이트 모드").tag(1)
                Text("다크 모드").tag(2)
            }
            .pickerStyle(.menu)
            .animation(nil, value: UUID()) //disable animation
            .onChange(of: modelData.saved.colorSchemeSetting){ _ in
                modelData.save()
            }
            Button(action: {requestReview()}){
                Text("리뷰 남기기")
                    .foregroundColor(.blue)
            }
            HStack{
                Button(action: logoutAction){
                    Text("로그아웃")
                        .foregroundColor(.blue)
                }
                .disabled(!loggedIn)
                Spacer()
                Text("\(modelData.studNo)")
            }
        }
        .listStyle(.inset)
        .padding()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(loggedIn: .constant(false))
            .environmentObject(ModelData())
    }
}
