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
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ColliderMask.arrow | ColliderMask.gestureBox {
            print("entrou na caixa")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ColliderMask.arrow | ColliderMask.gestureBox {
            print("saiu da caixa")
        }
    }
}
