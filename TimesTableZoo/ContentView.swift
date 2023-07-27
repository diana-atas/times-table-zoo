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
    
    @State private var selectedMultiplier = Int.random(in: 1...12)
    @State private var multiplicand = Int.random(in: 1...12)
    private var numberOfQuestions = [5, 10, 20]
    @State private var selectedNumberOfQuestions = 5
    @State private var questionNumber = 0
    
    @State private var playerAnswer = ""
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var animationAmount = 1.0
    
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
                        .background(selectedMultiplier == multiplier ? .red : .blue)
                        .clipShape(Circle())
                        .scaleEffect(selectedMultiplier == multiplier ? 1 : 0.8)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 100), value: selectedMultiplier)
                    }
                }
                .padding(.horizontal)
                
                //                    Stepper("Pick a multiplier: \(selectedMultiplier)", value: $selectedMultiplier, in: 1...12)
                
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
    
    func selectMultiplier(multiplier: Int) {
        selectedMultiplier = multiplier
    }
    
    func startGame() {
        gameManager.state = .gameStarted
        for _ in 1...selectedNumberOfQuestions {
            multiplicand = Int.random(in: 1...12)
            let answer = selectedMultiplier * multiplicand
            let question = Question(question: "What is \(selectedMultiplier) x \(multiplicand)?", correctAnswer: answer)
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
