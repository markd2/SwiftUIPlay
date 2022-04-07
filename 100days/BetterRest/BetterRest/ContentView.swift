//
//  ContentView.swift
//  BetterRest
//
//  Created by markd on 3/19/22.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
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
    
    func calculateBedtime() {
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up?")
                  .font(.headline)
                
                DatePicker("Please enter a time",
                           selection: $wakeUp,
                           displayedComponents: .hourAndMinute)
                  .labelsHidden()
                
                Text("Desired amount of sleep")
                  .font(.headline)
                Stepper("\(sleepAmount.formatted()) hours",
                        value: $sleepAmount,
                        in: 4...12, step: 0.25)
                
                Text("Daily coffee intake")
                  .font(.headline)
                Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",
                        value: $coffeeAmount, in: 1...20)
            }
              .navigationTitle("BetterRest")
              .toolbar {
                  Button("Calculate", action: calculateBedtime)
              }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
