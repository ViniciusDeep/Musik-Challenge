//
//  File.swift
//  Musik
//
//  Created by João Pedro Aragão on 09/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import SpriteKit

class GestureBox: SKNode {
    
    enum HighlightColors {
        case green
        case red
    }
    
    var shape: SKShapeNode!
    
    init(width: CGFloat = 0, radius: CGFloat = 0) {
        super.init()
        zPosition = 5
        
        shape = SKShapeNode()
        shape.path = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: -width/2, y: -width/2), size: CGSize(width: width, height: width)), cornerRadius: radius).cgPath
        shape.position = CGPoint(x: frame.midX, y: frame.midY)
        shape.fillColor = UIColor.clear
        shape.strokeColor = UIColor.white
        shape.lineWidth = 10
        addChild(shape)
        initPhysicsBody(width)
        
    }
    
    private func initPhysicsBody(_ width: CGFloat) {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: width))
        self.physicsBody?.categoryBitMask = ColliderMask.gestureBox
        self.physicsBody?.collisionBitMask = ColliderMask.none
        self.physicsBody?.contactTestBitMask = ColliderMask.arrow
    }
    
    func highlight(color: HighlightColors) {
        let hColor: UIColor!
        switch color {
        case .green:
            hColor = UIColor.green.withAlphaComponent(0.8)
        case .red:
            hColor = UIColor.red.withAlphaComponent(0.8)
        }
        let highlightAction = SKAction.run { self.shape.strokeColor = hColor }
        let wait = SKAction.wait(forDuration: 0.1)
        let getBackAction = SKAction.run { self.shape.strokeColor = .white }
        self.run(.sequence([highlightAction, wait, getBackAction]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
