//
//  ContentView.swift
//  TimesTableZoo
//
//  Created by Diana Atas on 13/07/23.
//

import SwiftUI

struct Question: Identifiable {
    var id = UUID()
    var question: String
    var answer: Int
}

struct ContentView: View {
    @State private var multiplier = Int.random(in: 1...12)
    @State private var multiplicand = Int.random(in: 1...12)
    private var numberOfQuestions = [5, 10, 20]
    @State private var selectedNumberOfQuestions = 5
    @State private var isGameActive = false
    
    @State var arrayOfQuestions = [Question]()
    
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
            
            Button("Start") {
                startGame()
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            if isGameActive {
                List {
                    ForEach(arrayOfQuestions) {question in
                        Text(question.question)
                    }
                }
            }
        }
        .padding()
    }
    
    func startGame() {
        isGameActive = true
        for _ in 1...selectedNumberOfQuestions {
            multiplicand = Int.random(in: 1...12)
            let answer = multiplier * multiplicand
            let question = Question(question: "What is \(multiplier) x \(multiplicand)?", answer: answer)
            arrayOfQuestions.append(question)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
