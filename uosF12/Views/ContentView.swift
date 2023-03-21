//
//  ContentView.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading){
            Text("UOS F12")
                .font(.title)
            Text("University Of Seoul F12")
                .font(.subheadline)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
