//
//  GameScene.swift
//  Musik
//
//  Created by Vinicius Mangueira Correia on 06/04/19.
//  Copyright © 2019 Vinicius Mangueira Correia. All rights reserved.
//

import SpriteKit
import GameplayKit
import TVUIKit

class MenuScene: SKScene {
    
    var startGameButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        addBackground()
    }
    
    private func addBackground() {
        let background = SKSpriteNode(imageNamed: "menu")
        background.size = UIScreen.main.bounds.size
        background.zPosition = 0
        background.position = .zero
        addChild(background)
        
        startGameButton = SKSpriteNode(imageNamed: "play")
        startGameButton.size = CGSize(width: UIScreen.main.bounds.width/5, height: UIScreen.main.bounds.width/5)
        startGameButton.zPosition = 2
        startGameButton.position = .zero
        addChild(startGameButton)
        
        let buttonBackground = SKSpriteNode(imageNamed: "raio1")
        buttonBackground.size = startGameButton.size
        buttonBackground.setScale(1.2)
        buttonBackground.zPosition = 1
        addChild(buttonBackground)
        
        var textures: [SKTexture] = []
        for i in 1...5 { textures.append(SKTexture(imageNamed: "raio\(i)")) }
        let run = SKAction.animate(with: textures, timePerFrame: 0.1)
        buttonBackground.run(SKAction.repeatForever(run))
    }
    
    func touchDown(atPoint pos : CGPoint) {
        print("down")
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        print("moved")
    }
    
    func touchUp(atPoint pos : CGPoint) {
        print("up")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        removeAllChildren()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }

    
  
    
    
    
}
