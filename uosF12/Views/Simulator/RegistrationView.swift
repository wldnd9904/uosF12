//
//  RegistrationView.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/28.
//

import SwiftUI

struct RegistrationView: View {
    let registration:Registration
    @Binding var grade:Float
    @Binding var ispass:Bool
    var body: some View {
        HStack {
            VStack{
                HStack{
                    Text(registration.name)
                        .font(.headline)
                    Spacer()
                }
                HStack{
                    Text("\(registration.pnt)학점")
                        .font(.subheadline)
                    if(registration.isMajor) {
                        Text("전공")
                            .font(.subheadline)
                    }
                    Spacer()
                }
            }
            Spacer()
            Picker("등급",selection: $grade){
                Text("A+").tag(Float(4.5))
                Text("A0").tag(Float(4.0))
                Text("B+").tag(Float(3.5))
                Text("B0").tag(Float(3.0))
                Text("C+").tag(Float(2.5))
                Text("C0").tag(Float(2.0))
                Text("D+").tag(Float(1.5))
                Text("D0").tag(Float(1.0))
                Text("F").tag(Float(0))
            }
            .opacity(ispass ? 0.0 : 1.0)
            .animation(.easeInOut, value: ispass)
            Toggle("패논패", isOn: $ispass)
                .toggleStyle(.button)
                .foregroundColor(ispass ? .blue : .gray)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            RegistrationView(registration: Registration.demo, grade: .constant(4.0), ispass:.constant(false))
                .padding()
            Spacer()
        }
    }
}
