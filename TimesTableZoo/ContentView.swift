//
//  ContentView.swift
//  TimesTableZoo
//
//  Created by Diana Atas on 13/07/23.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplier = Int.random(in: 1...12)
    private var multiplicand = Int.random(in: 1...12)
    private var product = 1
    private var numberOfQuestions = [5, 10, 20]
    @State private var selectedNumberOfQuestions = 5
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            Stepper("Pick a multiplier: \(multiplier)", value: $multiplier, in: 1...12)
            Section {
                Picker("Pick number of questions", selection: $selectedNumberOfQuestions) {
                    ForEach(numberOfQuestions, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Pick number of questions")
            }
            List {
                ForEach(0..<Int(selectedNumberOfQuestions), id: \.self) {_ in
                    Text("What is \(multiplier) x \(multiplicand)?")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
