//  GameScene.swift
//  Musik
//  Created by Vinicius Mangueira Correia on 06/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.

import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var gameManager = GameManager()
    private var scoreLabel: SKLabelNode!
    
    private let trackSound = SKAction.playSoundFileNamed("Forró Garage Track.mp3", waitForCompletion: false)
    
    private let velocity: Double = 600
    private var square: SKSpriteNode!
    var arrows = [Arrow]()
    var currentArrow: Arrow!
    var currentIndex: Int = 0
    var physicsDetection = PhysicsDetection()
    
    override func didMove(to view: SKView) {
        setupComponents()
        playGame()
        physicsWorld.gravity = CGVector.zero
        addGestures()
        arrows = Arrow.fromJson()
        currentArrow = arrows.first
        physicsWorld.contactDelegate = physicsDetection
    }
    
    private func addGestures() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwiped(sender:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwiped(sender:)))
        leftSwipe.direction = .left
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwiped(sender:)))
        downSwipe.direction = .down
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwiped(sender:)))
        upSwipe.direction = .up
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        self.view?.addGestureRecognizer(rightSwipe)
        self.view?.addGestureRecognizer(leftSwipe)
        self.view?.addGestureRecognizer(downSwipe)
        self.view?.addGestureRecognizer(upSwipe)
        self.view?.addGestureRecognizer(tap)
        
        view?.isUserInteractionEnabled = true
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        print("tap")
    }
    
    @objc private func handleSwiped(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch (sender.direction) {
            case .right:
                print("right")
                break;
            case .left:
                print("left")
                break;
            case .up:
                print("up")
                break;
            case .down:
                print("down")
                break;
            default:
                break;
            }
        }
        
    }
    private func setupComponents() {
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
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.fontSize = 94
        scoreLabel.text = String(GameManager.points)
        scoreLabel.alpha = 0.8
        scoreLabel.zPosition = 6
        scoreLabel.position = CGPoint(x: 0, y: 400)
        addChild(scoreLabel)

    }

    private func playGame() {
        let line = SKSpriteNode(imageNamed: "line")
        line.zPosition = 1
        line.size = CGSize(width: self.size.width * 2, height: 1800)
        line.alpha = 0.8
        line.position = .zero
        addChild(line)
        addArrows()
        run(trackSound)
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
        
    private func moveArrow() {}
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !GameManager.gameFinished{
            if !GameManager.gameStarted {
                playGame()
                GameManager.gameStarted = true
            } else {
            }
        }
    }
}
