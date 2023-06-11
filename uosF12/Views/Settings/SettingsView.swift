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
            VStack{
                Text("본 앱은 서울시립대학교 대학행정정보시스템의 API를 비상업적 목적으로 사용합니다.")
                    .padding(.top,20)
                    .padding(.bottom,5)
                Text("This application uses API of University Of Seoul Wise System for non-commercial purpose.").foregroundColor(.gray)
                Image("logo_vertical")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:200, height:200)
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
