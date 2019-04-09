//
//  GameManager.swift
//  Musik
//
//  Created by João Pedro Aragão on 08/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import Foundation

enum CroudStates {
    case great
    case good
    case meh
    case bad
    case terrible
}

protocol GameManagerDelegate {
    func correctNote()
    func wrongNote()
    func gameOver()
}

class GameManager {
    
    var gameStarted: Bool = false
    var gameFinished: Bool = false
    var croudState = CroudStates.meh
    var delegate: GameManagerDelegate?
    
    var score: Int = 0 {
        didSet {
            if score < 0 { score = 0 }
        }
    }
    
    func correctNote(_ perfect: Bool = false) {
        score += perfect ? 10 : 5
        delegate?.correctNote()
    }
    
    func wrongNote() {
        score -= 10
        delegate?.wrongNote()
    }
    
    func gameOver() {
        score = 100
        delegate?.gameOver()
    }
    
}
