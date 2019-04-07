//
//  GameScene.swift
//  Musik
//
//  Created by Vinicius Mangueira Correia on 06/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene {

    override func didMove(to view: SKView) {
        addBackground()
    }
    
    private func addBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        addChild(background)
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
       
    }
    
    
}
