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
    @Environment(\.colorScheme) var systemColorScheme
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .preferredColorScheme(modelData.colorScheme)
        }
    }
}
