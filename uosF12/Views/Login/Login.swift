//
//  Login.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/21.
//

import SwiftUI
let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)


struct Login: View {
    @EnvironmentObject var modelData:ModelData
    @State private var portalID = PortalID.blank
    var body: some View {
        VStack{
            Image("logo_horizontal")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:80, height:80)
                .padding(.bottom,75)
            TextField("ID", text: $portalID.userID)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(10.0)
                .padding(.bottom, 20)
            SecureField("PW", text: $portalID.password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(10.0)
                .padding(.bottom, 20)
            Button(action: {modelData.login()}){
                Text("로그인")
                     .font(.headline)
                     .foregroundColor(.white)
                     .padding()
                     .frame(width: 220, height: 60)
                     .background(.blue)
                     .cornerRadius(15.0)
            }
        }.padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
            .environmentObject(ModelData())
    }
}
