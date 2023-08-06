//
//  ContentView.swift
//  TimesTableZoo
//
//  Created by Diana Atas on 13/07/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameManager = GameManager()
    
    let columns = [
        GridItem(.adaptive(minimum: 90))
    ]
    
    var body: some View {
        VStack {
            switch gameManager.state {
            case .gameNotStarted:
                Text("Pick a multiplier")
                    .font(.headline)
                
                LazyVGrid(columns: columns) {
                    ForEach(1..<13) { multiplier in
                        Button {
                            selectMultiplier(multiplier: multiplier)
                        } label: {
                            Text("\(multiplier)")
                                .frame(width: 90, height: 90)
                        }
                        .padding(10)
                        .foregroundColor(.white)
                        .background(gameManager.selectedMultiplier == multiplier ? .red : .blue)
                        .clipShape(Circle())
                        .scaleEffect(gameManager.selectedMultiplier == multiplier ? 1 : 0.8)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 100), value: gameManager.selectedMultiplier)
                    }
                }
                .padding(.horizontal)
                
                Section {
                    Picker("Pick number of questions", selection: $gameManager.selectedNumberOfQuestions) {
                        ForEach(gameManager.numberOfQuestions, id: \.self) {
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
                    Text(gameManager.arrayOfQuestions[gameManager.questionNumber].question)
                    TextField("your answer", text: $gameManager.playerAnswer)
                        .keyboardType(.numberPad)
                    Button("Submit") {
                        submitAnswer()
                    }
                }
                .alert(gameManager.scoreTitle, isPresented: $gameManager.showingScore) {
                    Button("Continue", action: askQuestion)
                } message: {
                    Text(gameManager.scoreMessage)
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
    
    func selectMultiplier(multiplier: Int) {
        gameManager.selectedMultiplier = multiplier
    }
    
    func startGame() {
        
        gameManager.state = .gameStarted
        for _ in 1...gameManager.selectedNumberOfQuestions {
            gameManager.multiplicand = Int.random(in: 1...12)
            let answer = gameManager.selectedMultiplier * gameManager.multiplicand
            let question = Question(question: "What is \(gameManager.selectedMultiplier) x \(gameManager.multiplicand)?", correctAnswer: answer)
            gameManager.arrayOfQuestions.append(question)
        }
        print("startGame: \(gameManager.arrayOfQuestions)")
    }
    
    func askQuestion() {
        if gameManager.questionNumber == gameManager.selectedNumberOfQuestions - 1 {
            gameManager.state = .gameOver
        } else {
            gameManager.questionNumber += 1
        }
        gameManager.playerAnswer = ""
    }
    
    func submitAnswer() {
        let correctAnswer = gameManager.arrayOfQuestions[gameManager.questionNumber].correctAnswer
        print("submitAnswer, correctAnswer: \(correctAnswer)")
        print("submitAnswer, questionNumber: \(gameManager.questionNumber)")
        if Int(gameManager.playerAnswer) == correctAnswer {
            gameManager.scoreTitle = "Correct"
            gameManager.scoreMessage = ""
        } else {
            gameManager.scoreTitle = "Incorrect"
            gameManager.scoreMessage = "The correct answer is \(correctAnswer)."
        }
        gameManager.showingScore = true
    }
    
    func reset() {
        gameManager.state = .gameNotStarted
        gameManager.arrayOfQuestions = []
        gameManager.questionNumber = 0
        gameManager.playerAnswer = ""
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
