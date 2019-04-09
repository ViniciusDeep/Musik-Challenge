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
    var gameManager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stage = view as? SKView
        stage.ignoresSiblingOrder = true
        stage.showsNodeCount = true
        stage.showsPhysics = true
        presentScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameManager.gameFinished {
            if !gameManager.gameStarted{
                let gameScene = GameScene()
                gameManager.delegate = gameScene
                gameScene.gameManager = gameManager
                gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                gameScene.size = CGSize(width: 1920, height: 1080)
                gameScene.scaleMode = .aspectFill
                stage.presentScene(gameScene, transition: .crossFade(withDuration: 0.3))
                gameManager.gameStarted = true
            }
        }

    }
    
    private func presentScene() {
        let scene = MenuScene()
        scene.size = CGSize(width: 1920, height: 1080)
        scene.scaleMode = .aspectFill
        stage.presentScene(scene)
    }
}
