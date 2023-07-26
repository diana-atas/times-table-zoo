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
