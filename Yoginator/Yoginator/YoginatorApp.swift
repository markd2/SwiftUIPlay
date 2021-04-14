//
//  YoginatorApp.swift
//  Yoginator
//
//  Created by Mark Dalrymple on 4/12/21.
//

import SwiftUI

@main
struct YoginatorApp: App {

    @State var viewModel = ContentViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
