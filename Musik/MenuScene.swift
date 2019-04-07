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
    private var velocity: Double = 600
    var arrow: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        addBackground()
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
        startGameButton.alpha = 0
        playGame()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }

    private func playGame() {
        let line = SKSpriteNode(imageNamed: "line")
        line.zPosition = 1
        line.size = CGSize(width: self.size.width * 2, height: 2000)
        line.alpha = 0.5
        line.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        addChild(line)
        addArrows()
        
    }
    private func addArrows() {
        arrow = SKSpriteNode(imageNamed: "note1")
        arrow.zPosition = 2
        arrow.position = CGPoint(x: 1800, y: self.size.height/2)
        arrow.size = CGSize(width: 100, height: 100)
        addChild(arrow)
        moveArrow()
    }
    
    private func moveArrow() {
        let duration = Double(arrow.size.width/2)/velocity
        let moveArrowAction = SKAction.moveBy(x: -arrow.size.width, y: 0, duration: duration)
        let resetXAction = SKAction.moveBy(x: arrow.size.width/2, y: 0, duration: 0)
        let sequenceAction = SKAction.sequence([moveArrowAction, resetXAction])
        let repeatAction = SKAction.repeatForever(sequenceAction)
        arrow.run(repeatAction)
    }
    
}
