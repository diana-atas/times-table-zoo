//
//  ContentView.swift
//  TimesTableZoo
//
//  Created by Diana Atas on 13/07/23.
//

import SwiftUI

struct Question {
    var question: String
    var correctAnswer: Int
}

struct ContentView: View {
    @State private var multiplier = Int.random(in: 1...12)
    @State private var multiplicand = Int.random(in: 1...12)
    private var numberOfQuestions = [5, 10, 20]
    @State private var selectedNumberOfQuestions = 5
    @State private var questionNumber = 0
    @State private var isGameActive = false
    @State private var playerAnswer = ""
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
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
                Text(arrayOfQuestions[questionNumber].question)
                TextField("your answer", text: $playerAnswer)
                    .keyboardType(.numberPad)
                Button("Submit") {
                    submitAnswer()
                }
            }
        }
        .padding()
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
//        .alert("Game over", isPresented: $isGameActive) {
//            Button("Play again", action: reset)
//        }
    }
    
    func startGame() {
        isGameActive.toggle()
        for _ in 1...selectedNumberOfQuestions {
            multiplicand = Int.random(in: 1...12)
            let answer = multiplier * multiplicand
            let question = Question(question: "What is \(multiplier) x \(multiplicand)?", correctAnswer: answer)
            arrayOfQuestions.append(question)
        }
    }
    
    func askQuestion() {
        if questionNumber == selectedNumberOfQuestions - 1 {
            isGameActive.toggle()
        } else {
            questionNumber += 1
        }
    }
    
    func submitAnswer() {
        if Int(playerAnswer) == arrayOfQuestions[questionNumber].correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Incorrect"
        }
        showingScore = true
    }
    
    func reset() {
        isGameActive.toggle()
        arrayOfQuestions = []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
