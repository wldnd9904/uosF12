//
//  Login.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/21.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoginView: View {
    @EnvironmentObject var modelData:ModelData
    @State private var userID:String = ""
    @State private var password:String = ""
    @State private var loggingIn:Bool = false
    @State private var errorMessage:String = ""
    @FocusState private var focusField: Field?

    enum Field: Hashable {
        case id, pw
    }
    @Binding var loggedIn:Bool
    
    func loginAction() {
        loggingIn = true
        Task {
            do {
                try await modelData.login(userID:userID,password:password)
            } catch {
                switch(error){
                case is WiseError:
                    switch(error as! WiseError){
                        case .dataMissing:
                            errorMessage = "정보를 받아오지 못했습니다."
                        case .invalidServerResponse:
                        errorMessage = "서버가 응답하지 않습니다."
                        case .loginFailed:
                        errorMessage = "로그인 정보가 올바르지 않습니다."
                        case .duplicated:
                        errorMessage = "다른 곳에서 이미 로그인되어 있습니다."
                        default:
                        errorMessage = "알 수 없는 오류가 발생했습니다."
                        }
                default:
                    errorMessage = "알 수 없는 오류가 발생했습니다."
                }
                password = ""
                focusField = .pw
            }
            if modelData.studNo != "" {
                loggedIn = true
                UIApplication.shared.endEditing()
            }
            loggingIn = false
        }
    }
    
    var body: some View {
        VStack{
            Spacer()
            Image("logo_horizontal")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:80, height:80)
                .padding(.bottom,75)
            TextField("ID", text: $userID)
                .onSubmit {
                    focusField = .pw
                }
                .disableAutocorrection(true)
                .focused($focusField, equals: .id)
                .submitLabel(.next)
                .autocapitalization(.none)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(10.0)
                .contentShape(Rectangle())
                .onTapGesture {
                    focusField = .id
                }
                .padding(.bottom, 20)

            SecureField("PW", text: $password)
                .onSubmit {
                    if userID == "" {
                        focusField = .id
                    } else {
                        loginAction()
                    }
                }
                .disableAutocorrection(true)
                .focused($focusField, equals: Field.pw)
                .submitLabel(.go)
                .autocapitalization(.none)
                .padding()
                .background(.regularMaterial)
                .cornerRadius(10.0)
                .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.red, lineWidth: errorMessage == "" || password != "" ? 3 : 2)
                            .opacity(errorMessage == "" || password != "" ? 0.0 : 1.0)
                            .animation(.spring(), value:errorMessage == "" || password != "")
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    focusField = .pw
                }
                .padding(.bottom, 20)
            Button(action: loginAction){
                Text("로그인")
                     .font(.headline)
                     .foregroundColor(.white)
                     .padding()
                     .frame(width: 220, height: 60)
                     .background(.blue)
                     .cornerRadius(15.0)
                     .opacity((userID == "" || password == "" || loggingIn) ? 0.6: 1)
                     .scaleEffect((userID == "" || password == "" || loggingIn) ? 0.95: 1)
                     .animation(.spring(), value:(userID == "" || password == "" || loggingIn))
            }
            .disabled(userID == "" || password == "" || loggingIn)
            Spacer()
            if (errorMessage == "" || password != "") {
                Text("본 앱은 개인정보를 수집하거나 저장하지 않습니다.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                Text(errorMessage)
                .font(.subheadline)
                .foregroundColor(.red)
            }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loggedIn: .constant(false))
            .environmentObject(ModelData())
    }
}
