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
    var arrows = [Arrow]()
    var currentArrow: Arrow!
    var currentIndex: Int = 0
    var physicsDetection = PhysicsDetection()
    
    override func didMove(to view: SKView) {
        addBackground()
        playGame()
        physicsWorld.gravity = CGVector.zero
        arrows = Arrow.fromJson()
        currentArrow = arrows.first
        physicsWorld.contactDelegate = physicsDetection
    }
    
    private func addBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        addChild(background)
        background.zPosition = 0
        background.position = .zero
        
        square = SKSpriteNode(imageNamed: "square")
        square.zPosition = 5
        square.position = .zero
        square.size = CGSize(width: 260, height: 260)
        square.physicsBody = SKPhysicsBody(rectangleOf: square.size)
        square.physicsBody?.categoryBitMask = ColliderMask.gestureBox
        square.physicsBody?.collisionBitMask = ColliderMask.none
        square.physicsBody?.contactTestBitMask = ColliderMask.arrow
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
        line.position = .zero
        addChild(line)
        addArrows()
    }
    
    private func addArrows() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            if self.currentIndex < self.arrows.count - 1 {
                self.currentArrow.sprite.size = CGSize(width: 100, height: 100)
                self.currentArrow.position = CGPoint(x: -self.size.width/2, y: 0)
                self.addChild(self.currentArrow)
                self.currentArrow.physicsBody?.velocity.dx = 600
                self.currentIndex += 1
                self.currentArrow = self.arrows[self.currentIndex]
                self.addArrows()
            }
        }
    }
    
    private func moveArrow() {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playGame()
    }
}
