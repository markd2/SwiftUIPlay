//
//  ContentView.swift
//  ExpenseSieve
//
//  Created by markd on 4/10/22.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Greeble"
    @Published var lastName = "Bork"
}

struct SecondView: View {
    let name: String
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Text("Snorgle Bork \(name)")
        Button("Bite Me") {
            dismiss()
        }
    }
}

struct ContentView: View {
    @StateObject private var user = User()
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "blorfle")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
