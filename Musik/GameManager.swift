//
//  GameManager.swift
//  Musik
//
//  Created by João Pedro Aragão on 08/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import Foundation

class GameManager {
    
    static var gameStarted: Bool = false
    static var gameFinished: Bool = false
    static var points: Int = 100
    
    func correctNote() {
        GameManager.points += 5
    }
    
    func wrongNote() {
        if GameManager.points == 0 {
            gameOver()
            return
        }
        GameManager.points -= 10
    }
    
    func gameOver() {
        GameManager.points = 100
    }
    
}
