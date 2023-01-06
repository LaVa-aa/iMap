//
//  iMapApp.swift
//  iMap
//
//

import SwiftUI

@main
struct iMapApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: PinsViewModel(cities: []))
        }
    }
}
