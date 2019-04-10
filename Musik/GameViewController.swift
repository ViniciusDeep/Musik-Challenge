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
        presentScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameManager.gameFinished {
            if !gameManager.gameStarted{
                let gameScene = GameScene()
                gameManager.delegate = gameScene
                gameScene.gameManager = gameManager
                gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                gameScene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                gameScene.scaleMode = .aspectFill
                stage.presentScene(gameScene, transition: .crossFade(withDuration: 0.3))
            }
        }

    }
    
    public func presentScene() {
        let scene = MenuScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .aspectFill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        stage.presentScene(scene)
    }
}
