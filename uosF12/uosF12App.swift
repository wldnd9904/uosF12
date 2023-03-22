//
//  uosF12App.swift
//  uosF12
//
//  Created by 최지웅 on 2023/03/14.
//

import SwiftUI

@main
struct uosF12App: App {
    @StateObject var modelData:ModelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
