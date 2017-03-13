//
//  GameScene.swift
//  Breakout
//
//  Created by Dilip Rao on 3/13/17.
//  Copyright © 2017 Dilip Rao. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        createBackground()
    }
    
    override func touchesBegan(_touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func createBackground() {
        let stars = SKTexture(imageNamed: "stars")
        for i in 0...1 {
            let starsBackground = SKSpriteNode(texture: stars)
            starsBackground.zPosition = -1
            starsBackground.position = CGPoint(x:0, y: starsBackground.size.height * CGFloat(i))
            addChild(starsBackground)
            let moveDown = SKAction.moveBy (x: 0, y: -starsBackground.size.height, duration: 0)
            let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
            let moveLoop = SKAction.sequence ([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            starsBackground.run(moveForever)
        }
    }
    
}
