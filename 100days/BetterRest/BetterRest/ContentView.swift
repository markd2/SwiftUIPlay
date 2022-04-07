//
//  ContentView.swift
//  BetterRest
//
//  Created by markd on 3/19/22.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now

    func dateSplunge() -> Date {
        var components = DateComponents()
        components.hour = 8
        components.minute = 2

        let date = Calendar.current.date(from: components)!
        return date
    }

    func dateSplungeTwo() {
        let someDate = Date()
        let components = Calendar.current.dateComponents([.hour, .minute], from: someDate)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        
        _ = hour
        _ = minute
    }

    init() {
        wakeUp = dateSplunge()
        print("\(wakeUp)")
    }

    var body: some View {
        VStack {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            DatePicker("Please enter a date", selection: $wakeUp,
                       in: Date.now...)
              .labelsHidden() // gives label to accessibility
            Text("Splunge")
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
