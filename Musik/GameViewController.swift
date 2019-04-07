//
//  GameViewController.swift
//  Musik
//
//  Created by Vinicius Mangueira Correia on 06/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    
    var stage: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stage = view as! SKView
        stage.ignoresSiblingOrder = true
        presentScene()
    }
    
    private func presentScene() {
        let scene = MenuScene()
        scene.size = CGSize(width: 1920, height: 1080)
        scene.scaleMode = .aspectFill
        stage.presentScene(scene)
    }
}
