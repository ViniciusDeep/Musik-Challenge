//
//  GameScene.swift
//  Musik
//
//  Created by Vinicius Mangueira Correia on 06/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import SpriteKit
import GameplayKit
import TVUIKit

class MenuScene: SKScene {
    
    var startGameButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        addBackground()
    }
    
    private func addGestures() {
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRecognizer.direction = .right
        self.view?.addGestureRecognizer(swipeRecognizer)
        if swipeRecognizer.direction == .right {
        }
    }
    
    private func addBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        addChild(background)
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        startGameButton = SKSpriteNode(imageNamed: "startGame")
        addChild(startGameButton)
        startGameButton.zPosition = 1
        startGameButton.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print("down")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        print("moved")
    }
    
    func touchUp(atPoint pos : CGPoint) {
        print("up")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeAllChildren()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }

    
  
    
    
    
}
