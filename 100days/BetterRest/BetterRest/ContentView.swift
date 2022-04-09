//
//  ContentView.swift
//  BetterRest
//
//  Created by markd on 3/19/22.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    @State private var sleepTime = Date()

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components)!
    }

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
        calculateBedtime()
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute],
                                                             from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount))
            sleepTime = wakeUp - prediction.actualSleep

        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")
                      .font(.headline)) {
                    DatePicker("Please enter a time",
                               selection: $wakeUp.onChange(calculateBedtime),
                               displayedComponents: .hourAndMinute)
                      .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired amount of sleep")
                      .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours",
                            value: $sleepAmount.onChange(calculateBedtime),
                            in: 4...12, step: 0.25)
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Daily coffee intake")
                      .font(.headline)
                    Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups",
                            value: $coffeeAmount.onChange(calculateBedtime), in: 1...20)
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("Go to sleep time \(sleepTime.formatted(date: .omitted, time: .shortened))")
                }
            }

            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }

    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
