//
//  F12Item.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/30.
//

import SwiftUI

struct F12ItemView: View {
    var item: F12Item
    var body: some View {
        HStack {
            VStack{
                HStack{
                    Text(item.name)
                        .font(.headline)
                    Spacer()
                }
                HStack{
                    Text(String(item.pnt)+"학점")
                    Spacer()
                }
            }
            Spacer()
            Text(String(item.gradeStr))
                .foregroundColor(gradeColor(item.gradeStr))
        }
    }
}

struct F12ItemView_Previews: PreviewProvider {
    static var previews: some View {
        F12ItemView(item:F12Item.demo)
    }
}
