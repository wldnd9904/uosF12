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
            Button(action: {requestReview()}){
                Text("리뷰 남기기")
            }
            HStack{
                Button(action: logoutAction){
                    Text("로그아웃")
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
