//
//  PhysicsDetection.swift
//  Musik
//
//  Created by João Pedro Aragão on 08/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import SpriteKit

struct ColliderMask {
    static let none         : UInt32 = 0
    static let arrow        : UInt32 = 0x1 << 1
    static let gestureBox   : UInt32 = 0x1 << 2
}

class PhysicsDetection: NSObject, SKPhysicsContactDelegate {
    var collision: UInt32!
    var contact: SKPhysicsContact!
    func didBegin(_ contact: SKPhysicsContact) {
        self.contact = contact
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ColliderMask.arrow | ColliderMask.gestureBox {
            if let arrow = contact.bodyA.node as? Arrow,
                let scene = arrow.scene as? GameScene {
                arrow.isInsideGestureBox = true
                scene.arrowInsideBox = arrow
            } else if let arrow = contact.bodyB.node as? Arrow,
                let scene = arrow.scene as? GameScene {
                arrow.isInsideGestureBox = true
                scene.arrowInsideBox = arrow
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ColliderMask.arrow | ColliderMask.gestureBox {
            if let arrow = contact.bodyA.node as? Arrow,
                let scene = arrow.scene as? GameScene {
                arrow.isInsideGestureBox = false
                scene.arrowInsideBox = nil
            } else if let arrow = contact.bodyB.node as? Arrow,
                let scene = arrow.scene as? GameScene {
                arrow.isInsideGestureBox = false
                scene.arrowInsideBox = nil
            }
        }
    }
}
