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
    private var velocity: Double = 600
    private var square: SKSpriteNode!
    var arrow: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        addBackground()
        playGame()
        physicsWorld.gravity = CGVector.zero
        
    }
    
    private func addBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        addChild(background)
        background.zPosition = 0
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        square = SKSpriteNode(imageNamed: "square")
        square.zPosition = 5
        square.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        square.size = CGSize(width: 260, height: 260)
        addChild(square)
        
    }
    private func addGestures() {
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: "swiped:")
        swipeRecognizer.direction = .right
        self.view?.addGestureRecognizer(swipeRecognizer)
        if swipeRecognizer.direction == .right {
        }
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
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let randomNumber = Int.random(in: 1...5)
                self.arrow = SKSpriteNode(imageNamed: "note\(randomNumber)")
                self.arrow.zPosition = 3
                self.arrow.position = CGPoint(x: 1800, y: self.size.height/2)
                self.arrow.size = CGSize(width: 100, height: 100)
                self.addChild(self.arrow)
                self.moveArrow()
        }
    }
    
  private func moveArrow() {
        arrow.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2-100)
        arrow.physicsBody?.velocity = CGVector(dx: -velocity, dy: 0)
        deleteArrow()
    
    
    
//        let duration = Double(arrow.size.width/2)/velocity
//        let moveArrowAction = SKAction.moveBy(x: -arrow.size.width, y: 0, duration: duration)
//        let resetXAction = SKAction.moveBy(x: arrow.size.width/2, y: 0, duration: 0)
//        let sequenceAction = SKAction.sequence([moveArrowAction, resetXAction])
//        let repeatAction = SKAction.repeatForever(sequenceAction)
//        arrow.run(repeatAction)
//        playGame()
//        deleteArrow()
    }
    
    
    private func deleteArrow() {
        if arrow.position == CGPoint(x: 0, y: self.size.height/2) {
            removeChildren(in: [arrow])
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playGame()
    }
}
