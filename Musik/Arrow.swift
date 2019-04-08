//
//  Note.swift
//  Musik
//
//  Created by João Pedro Aragão on 08/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import SpriteKit

class Arrow: SKNode {
    
    var sprite: SKSpriteNode!
    var direction: String!
    
    init(withDirection direction: String) {
        super.init()
        name = "Arrow"
        zPosition = 100
        
        if direction != "Up"
        && direction != "Down"
        && direction != "Right"
        && direction != "Left"
        && direction != "Tap" {
            sprite = SKSpriteNode(texture: nil, color: .clear, size: .zero)
        } else {
            let texture = SKTexture(imageNamed: direction)
            sprite = SKSpriteNode(texture: texture)
        }
        
        addChild(sprite)
        initPhysicsBody()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        self.physicsBody?.categoryBitMask = ColliderMask.arrow
        self.physicsBody?.collisionBitMask = ColliderMask.none
        self.physicsBody?.contactTestBitMask = ColliderMask.gestureBox
    }
    
    private func playSound() {
        SKAction.playSoundFileNamed(direction, waitForCompletion: false)
    }
    
    static func fromJson() -> [Arrow] {
        
        var jsonResult = [String]()
        var arrows = [Arrow]()
        
        if let path = Bundle.main.path(forResource: "Arrows", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let result = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String]
                jsonResult = result
            } catch {
                NSLog(error.localizedDescription)
            }
        }
        
        for result in jsonResult {
            let note = Arrow(withDirection: result)
            arrows.append(note)
        }
        
        return arrows
        
    }
    
}
