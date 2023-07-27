//
//  ContentView.swift
//  TimesTableZoo
//
//  Created by Diana Atas on 13/07/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameManager = GameManager()
    @State var arrayOfQuestions = [Question]()
    
    @State private var multiplier = Int.random(in: 1...12)
    @State private var multiplicand = Int.random(in: 1...12)
    private var numberOfQuestions = [5, 10, 20]
    @State private var selectedNumberOfQuestions = 5
    @State private var questionNumber = 0
    
    @State private var playerAnswer = ""
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    var body: some View {
        VStack {
            switch gameManager.state {
            case .gameNotStarted:
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
                
            case .gameStarted:
                VStack {
                    Text(arrayOfQuestions[questionNumber].question)
                    TextField("your answer", text: $playerAnswer)
                        .keyboardType(.numberPad)
                    Button("Submit") {
                        submitAnswer()
                    }
                }
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text(scoreMessage)
                }
                
            case .gameOver:
                
                Text("Game over.")
                Button("Play again") {
                    reset()
                }
                
            }
        }
        .padding()
    }
    
    func startGame() {
        gameManager.state = .gameStarted
        for _ in 1...selectedNumberOfQuestions {
            multiplicand = Int.random(in: 1...12)
            let answer = multiplier * multiplicand
            let question = Question(question: "What is \(multiplier) x \(multiplicand)?", correctAnswer: answer)
            arrayOfQuestions.append(question)
        }
    }
    
    func askQuestion() {
        if questionNumber == selectedNumberOfQuestions - 1 {
            gameManager.state = .gameOver
        } else {
            questionNumber += 1
        }
        playerAnswer = ""
    }
    
    func submitAnswer() {
        let correctAnswer = arrayOfQuestions[questionNumber].correctAnswer
        if Int(playerAnswer) == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Incorrect"
            scoreMessage = "The correct answer is \(correctAnswer)."
        }
        showingScore = true
    }
    
    func reset() {
        gameManager.state = .gameNotStarted
        arrayOfQuestions = []
        questionNumber = 0
        playerAnswer = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation"))
            .previewDisplayName("iPhone SE (3rd generation")
    }
}
