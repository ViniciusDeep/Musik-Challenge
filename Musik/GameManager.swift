//
//  GameManager.swift
//  Musik
//
//  Created by João Pedro Aragão on 08/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import Foundation

protocol GameManagerDelegate {
    func correctNote()
    func wrongNote()
    func gameOver(win: Bool)
}

class GameManager {
    
    var gameStarted: Bool = false
    var gameFinished: Bool = false
    var delegate: GameManagerDelegate?
    
    var score: Int = 0 {
        didSet {
            if score < 0 { score = 0 }
        }
    }
    
    func correctNote(_ perfect: Bool = false) {
        if gameStarted {
            score += perfect ? 10 : 5
            delegate?.correctNote()
        }
    }
    
    func wrongNote() {
        if gameStarted {
            score -= 10
            delegate?.wrongNote()
        }
    }
    
    func gameOver(win: Bool) {
        if gameFinished {
            delegate?.gameOver(win: win)
            if win { score = 0 }
            gameFinished = true
        }
    }
    
}
