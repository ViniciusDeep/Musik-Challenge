//
//  GameManager.swift
//  Musik
//
//  Created by João Pedro Aragão on 08/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import Foundation

class GameManager {
    
    var points: Int = 100
    
    func correctNote() {
        points += 5
    }
    
    func wrongNote() {
        if points == 0 {
            gameOver()
            return
        }
        points -= 10
    }
    
    func gameOver() {
        points = 100
    }
    
}
