//  GameScene.swift
//  Musik
//  Created by Vinicius Mangueira Correia on 06/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.

import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameManager: GameManager!
    private var scoreLabel: SKLabelNode!
    private var playerSax: SKSpriteNode!
    
    private let trackSound = SKAction.playSoundFileNamed("Amor Falso.mp3", waitForCompletion: false)
    
    var velocity: Double {
        get { return 600 }
    }
    
    var spawnTime: Double {
        get { return 0.5 }
    }
    
    private var square: SKSpriteNode!
    
    var arrows = [Arrow]()
    var audiences = [SKSpriteNode]()
    
    var currentArrow: Arrow!
    var currentIndex: Int = 0
    
    var arrowInsideBox: Arrow?
    var gestured = false
    
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
        gestured = true
        if let arrowInBox = arrowInsideBox {
            let perfect = isPerfect(arrow: arrowInBox)
            arrowInBox.direction == .tap ? gameManager.correctNote(perfect) : gameManager.wrongNote()
        } else {
            gameManager.wrongNote()
        }
    }
    
    func isPerfect(arrow: Arrow) -> Bool {
        let hitBoxWidth: CGFloat = 20
        let right = (square.position.x...(square.position.x + hitBoxWidth/2)).contains(arrow.position.x)
        let left = ((square.position.x - hitBoxWidth/2)...square.position.x).contains(arrow.position.x)
        return right || left
    }
    
    @objc private func handleSwiped(sender: UISwipeGestureRecognizer) {
        gestured = true
        if sender.state == .ended {
            if let arrowInBox = arrowInsideBox {
                let perfect = isPerfect(arrow: arrowInBox)
                switch (sender.direction) {
                case .right:
                    arrowInBox.direction == .right ? gameManager.correctNote(perfect) : gameManager.wrongNote()
                case .left:
                    arrowInBox.direction == .left ? gameManager.correctNote(perfect) : gameManager.wrongNote()
                case .up:
                    arrowInBox.direction == .up ? gameManager.correctNote(perfect) : gameManager.wrongNote()
                case .down:
                    arrowInBox.direction == .down ? gameManager.correctNote(perfect) : gameManager.wrongNote()
                default:
                    gameManager.wrongNote()
                }
            } else {
                gameManager.wrongNote()
            }
        }
        
    }
    
    private func setupComponents() {
        let background = SKSpriteNode(imageNamed: "stage")
        background.size = UIScreen.main.bounds.size
        addChild(background)
        background.zPosition = 0
        background.position = .zero
        
        let line = SKSpriteNode(imageNamed: "display")
        line.zPosition = 1
        let ratio = line.size.height/line.size.width
        line.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.size.width * ratio)
        line.position = CGPoint(x: 0, y: UIScreen.main.bounds.height/2 - UIScreen.main.bounds.height/4)
        addChild(line)
        
        square = SKSpriteNode(imageNamed: "match2")
        square.zPosition = 5
        square.position = line.position
        square.size = CGSize(width: line.size.height, height: line.size.height)
        square.physicsBody = SKPhysicsBody(rectangleOf: square.size)
        square.physicsBody?.categoryBitMask = ColliderMask.gestureBox
        square.physicsBody?.collisionBitMask = ColliderMask.none
        square.physicsBody?.contactTestBitMask = ColliderMask.arrow
        addChild(square)
        
        scoreLabel = SKLabelNode(fontNamed: "LifeSavers-Bold")
        scoreLabel.fontSize = 94
        scoreLabel.text = "Score: \(gameManager.score)"
        scoreLabel.alpha = 0.8
        scoreLabel.zPosition = 6
        scoreLabel.position = CGPoint(x: 0, y: -450)
        addChild(scoreLabel)
        
        
        playerSax = SKSpriteNode(imageNamed: "sax1")
        playerSax.zPosition = 10
        playerSax.position = CGPoint(x: 0, y: -100)
        addChild(playerSax)
        
        var textures: [SKTexture] = []
        for i in 1...5 { textures.append(SKTexture(imageNamed: "sax\(i)")) }
        let run = SKAction.animate(with: textures, timePerFrame: 0.2)
        playerSax.run(SKAction.repeatForever(run))

    }

    private func playGame() {
        addArrows()
        run(trackSound)
    }
    
    private func addArrows() {
        DispatchQueue.main.asyncAfter(deadline: .now() + spawnTime) {
            if self.currentIndex == self.arrows.count - 1 { self.gameOver(win: true) }
            if self.currentIndex < self.arrows.count - 1 {
                self.currentArrow.sprite.size = CGSize(width: UIScreen.main.bounds.height/10.8, height: UIScreen.main.bounds.height/10.8)
                self.currentArrow.position = CGPoint(x: -self.size.width/2, y: self.square.position.y)
                self.addChild(self.currentArrow)
                self.currentArrow.physicsBody?.velocity.dx = CGFloat(self.velocity)
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
        if !gameManager.gameFinished{
            if !gameManager.gameStarted {
                playGame()
                gameManager.gameStarted = true
            } else {
            }
        }
    }
}

extension GameScene: GameManagerDelegate {
    func addRemoveArrowAction(after: TimeInterval, arrowToRemove: Arrow?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            if let arrow = arrowToRemove {
                var actions = [SKAction]()
                for _ in 0...10 {
                    let action = SKAction.run { arrow.alpha -= 0.1 }
                    actions.append(action)
                    actions.append(.wait(forDuration: 0.05))
                }
                actions.reverse()
                let remove = SKAction.run { arrow.removeFromParent() }
                actions.append(remove)
                let sequence = SKAction.sequence(actions)
                self.run(sequence)
            }
        }
    }
    
    func updateUI() {
        scoreLabel.text = "\(gameManager.score)"
    }
    
    func correctNote() {
        updateUI()
        guard let arrow = arrowInsideBox else { return }
        addRemoveArrowAction(after: 0, arrowToRemove: arrow)
    }
    
    func wrongNote() {
        updateUI()
        guard let arrow = arrowInsideBox else { return }
        addRemoveArrowAction(after: 0, arrowToRemove: arrow)
        if audiences.isEmpty { gameManager.gameOver(win: false) }
    }
    
    func gameOver(win: Bool) {
        updateUI()
    }
}
