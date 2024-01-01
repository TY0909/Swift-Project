//
//  ContentView.swift
//  BetterRest
//
//  Created by M Sapphire on 2023/11/16.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeup = defaultTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var bedTime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeup)
            let hour = (components.hour ?? 0) * 60 * 60
            let minite = (components.minute ?? 0) * 60
            
            let predicttion = try model.prediction(wake: Double(hour + minite), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeup - predicttion.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        }catch {
            return "Error"
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("When do you want to wake up") {
                    DatePicker("Please enter a time", selection: $wakeup, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section("When do you want to wake up") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section("Daily coffee intake") {
                    Picker(coffeeAmount == 1 || coffeeAmount == 0 ? "1 cup" : "\(coffeeAmount) cups", selection: $coffeeAmount) {
                        ForEach(0..<21) {
                            Text($0 == 1 || $0 == 0 ? "\($0) cup" : "\($0) cups")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Your bedtime is") {
                    Text(bedTime)
                }
                
            }
            .navigationTitle("Bedtime Calculate")
            /*.toolbar {
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }*/
        }
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeup)
            let hour = (components.hour ?? 0) * 60 * 60
            let minite = (components.minute ?? 0) * 60
            
            let predicttion = try model.prediction(wake: Double(hour + minite), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeup - predicttion.actualSleep
            
            alertTitle = "You bed time is"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        }catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there is a problem occured"
        }
        
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
