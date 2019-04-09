//
//  Note.swift
//  Musik
//
//  Created by João Pedro Aragão on 08/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import SpriteKit

enum ArrowType: String {
    case right = "Right"
    case left = "Left"
    case up = "Up"
    case down = "Down"
    case tap = "Tap"
}

class Arrow: SKNode {
    
    var sprite: SKSpriteNode!
    var direction: ArrowType?
    var isInsideGestureBox: Bool = false
    
    init(withDirection direction: String) {
        super.init()
        name = "Arrow"
        zPosition = 100
        
        self.direction = ArrowType(rawValue: direction)
        
        if let arrow = self.direction {
            let texture = SKTexture(imageNamed: arrow.rawValue)
            sprite = SKSpriteNode(texture: texture)
        } else {
            sprite = SKSpriteNode(texture: nil, color: .clear, size: .zero)
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
        if let arrow = direction?.rawValue {
            SKAction.playSoundFileNamed(arrow, waitForCompletion: false)
        }
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
