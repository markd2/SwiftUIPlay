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
    var body: some View {
        Text("Snorgle Bork")
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
            SecondView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
