//
//  GameScene.swift
//  Breakout
//
//  Created by Dilip Rao on 3/13/17.
//  Copyright © 2017 Dilip Rao. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball = SKShapeNode()
    var paddle = SKSpriteNode()
    var brick = SKSpriteNode()
    var bricks = [SKSpriteNode]()
    var startLabel = SKLabelNode()
    var extraBalls = SKLabelNode()
    var score = SKLabelNode()
    var numberOfBricks = 0
    
    override func didMove(to view: SKView) {
        createBackground()
        makeBall()
        makePaddle()
        makeBrick()
        makeBricks(x: 0, y: 0)
        makeLoseZone()
        moveBall()
        multipleBricks()
        
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    func reset() {
        ball.removeFromParent()
        makeBall()
        makePaddle()
        makeBrick()
        makeLoseZone()
        
        
    }
    override func touchesBegan(_ _touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }
    
    override func touchesMoved(_ _touches: Set<UITouch>, with event: UIEvent?) {
        for drag in _touches{
            let location = drag.location(in:self)
            // when finger is dragging paddle, it will move.
            paddle.position.x = location.x
            // when let go, it will stay in positon.
            
        }
        
        
        
    }
    
    func labels () {
        
    }
    
    func createBackground() {
        let stars = SKTexture(imageNamed: "stars")
        for i in 0...1 {
            let starsBackground = SKSpriteNode(texture: stars)
            starsBackground.zPosition = -1
            starsBackground.position = CGPoint(x:0, y: starsBackground.size.height * CGFloat(i))
            addChild(starsBackground)
            let moveDown = SKAction.moveBy (x: 0, y: -starsBackground.size.height, duration: 20)
            let moveReset = SKAction.moveBy(x: 0, y: starsBackground.size.height, duration: 0)
            let moveLoop = SKAction.sequence ([moveDown, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            starsBackground.run(moveForever)
        }
    }
    
    func moveBall() {
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 5))
    }
    
    func makeBall() {
        ball = SKShapeNode(circleOfRadius: 10)
        ball.position = CGPoint (x: frame.midX, y: frame.midY)
        ball.strokeColor = UIColor.black
        ball.fillColor = UIColor.yellow
        ball.name = "ball"
        //physics shape matches ball image
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        // ignores all forces and impulses
        ball.physicsBody?.isDynamic = false
        // use precise collision deteection
        ball.physicsBody?.usesPreciseCollisionDetection = true
        // no loss of energy from friction
        ball.physicsBody?.friction = 0
        // gravity is not a factor
        ball.physicsBody?.affectedByGravity = false
        //bounces fully off of other objects
        ball.physicsBody?.restitution = 1
        //does not slow down over time
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        
        addChild(ball) // add ball object to the view
    }
    
    func makePaddle() {
        paddle = SKSpriteNode(color: UIColor.white,
                              size: CGSize(width: frame.width/4,
                                           height: frame.height/25))
        paddle.position = CGPoint(x: frame.midX,
                                  y: frame.minY + 125)
        paddle.name = "paddle"
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        addChild(paddle)
    }
    
    
    
    func multipleBricks() {
        let countB = Int(frame.width) / 80
        let height = Int(frame.maxY)
        let xOffset = (Int(frame.width) - (countB * 100)) / 5 + Int(frame.minX) + 40
        for x in 0..<countB{makeBricks(x: x * 90 + xOffset, y: height - 100) }
        for x in 0..<countB{makeBricks(x: x * 90 + xOffset, y: height - 150) }
        for x in 0..<countB{makeBricks(x: x * 90 + xOffset, y: height - 200) }
        for x in 0..<countB{makeBricks(x: x * 90 + xOffset, y: height - 250) }
        
    }
    
    func makeBricks(x: Int, y: Int) {
        let brick = SKSpriteNode(imageNamed: "brick")
        
        brick.position = CGPoint(x: x, y: y)
        brick.name = "brick"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
        numberOfBricks += 1
        bricks.append(brick)
    }
    
    func makeBrick() {
        brick = SKSpriteNode(color: UIColor.blue,
                             size: CGSize(width: frame.width/5,
                                          height: frame.height/25))
        brick.position = CGPoint(x: frame.midX,
                                 y: frame.maxY - 30)
        brick.name = "brick"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
    }
    func makeLoseZone() {
        let loseZone = SKSpriteNode (color: UIColor.red,
                                     size: CGSize(width: frame.width,
                                                  height: 50))
        loseZone.position = CGPoint(x: frame.midX,
                                    y: frame.minY + 25)
        loseZone.name = "loseZone"
        loseZone.physicsBody = SKPhysicsBody(rectangleOf: loseZone.size)
        loseZone.physicsBody?.isDynamic = false
        addChild(loseZone)
    }
}
