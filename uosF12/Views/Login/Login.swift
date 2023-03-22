//
//  Login.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/21.
//

import SwiftUI
extension Color{
    static let lightGray = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
}


struct Login: View {
    @EnvironmentObject var modelData:ModelData
    @State private var userID:String = ""
    @State private var password:String = ""
    var body: some View {
        VStack{
            Spacer()
            Image("logo_horizontal")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:80, height:80)
                .padding(.bottom,75)
            TextField("ID", text: $userID)
                .autocapitalization(.none)
                .padding()
                .background(Color.lightGray)
                .cornerRadius(10.0)
                .padding(.bottom, 20)
            SecureField("PW", text: $password)
                .autocapitalization(.none)
                .padding()
                .background(Color.lightGray)
                .cornerRadius(10.0)
                .padding(.bottom, 20)
            Button(action: {modelData.login(userID: userID, password: password)}){
                Text("로그인")
                     .font(.headline)
                     .foregroundColor(.white)
                     .padding()
                     .frame(width: 220, height: 60)
                     .background(.blue)
                     .cornerRadius(15.0)
                     .grayscale((userID == "" || password == "") ? 1 : 0)
                     .scaleEffect((userID == "" || password == "") ? 0.95: 1)
                     .animation(.spring(), value:(userID == "" || password == ""))
            }
            .disabled(userID == "" || password == "")
            Spacer()
            Text("본 앱은 개인정보를 수집하거나 저장하지 않습니다.")
                .font(.subheadline)
                .foregroundColor(.gray)
            
        }.padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .environmentObject(ModelData())
    }
}
