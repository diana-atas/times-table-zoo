//
//  GameManager.swift
//  TimesTableZoo
//
//  Created by Diana Atas on 26/07/23.
//

import Foundation

class GameManager: ObservableObject {
    @Published var state: GameState = .gameNotStarted
    
    enum GameState {
        case gameStarted
        case gameNotStarted
        case gameOver
    }
    
    @Published var arrayOfQuestions = [Question]()
    
    @Published var selectedMultiplier = Int.random(in: 1...12)
    @Published var multiplicand = Int.random(in: 1...12)
    var numberOfQuestions = [5, 10, 20]
    @Published var selectedNumberOfQuestions = 5
    @Published var questionNumber = 0
    
    @Published var playerAnswer = ""
    
    @Published var showingScore = false
    @Published var scoreTitle = ""
    @Published var scoreMessage = ""
    
    @Published var animationAmount = 1.0
    
    // structure to consider next time
//    @Published var state: GameState = .notActive(.gamePrep)

//    enum GameState {
//        case active
//        case notActive(GameIsNotActive)
//
//        enum GameIsNotActive {
//            case gamePrep
//            case gameOver
//        }
//    }
}
