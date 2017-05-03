//
//  GameScene.swift
//  GoalBreaker
//
//  Created by student3 on 5/1/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ball = SKSpriteNode()
    var rightBlock1 = SKSpriteNode()
    var rightBlock2 = SKSpriteNode()
    var rightBlock3 = SKSpriteNode()
    var rightBlock4 = SKSpriteNode()
    var leftBlock1 = SKSpriteNode()
    var leftBlock2 = SKSpriteNode()
    var leftBlock3 = SKSpriteNode()
    var leftBlock4 = SKSpriteNode()
    var redPaddle = SKSpriteNode()
    var bluePaddle = SKSpriteNode()
    
    var counter = 0
    var label = SKLabelNode()
    var started = false
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        label = SKLabelNode(text: "0")
        label.fontSize = 150.0
        label.position = CGPoint(x: 0, y: -35)
        addChild(label)
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        redPaddle = self.childNode(withName: "leftPlayer") as! SKSpriteNode
        bluePaddle = self.childNode(withName: "rightPlayer") as! SKSpriteNode
    
        let bottomLeft = CGPoint(x: frame.origin.x, y: frame.origin.y)
        let bottomRight = CGPoint(x: -frame.origin.x, y: frame.origin.y)
        let topLeft = CGPoint(x: frame.origin.x, y: -frame.origin.y)
        let topRight = CGPoint(x: -frame.origin.x, y: -frame.origin.y)

        let bottom = SKNode()
        bottom.name = "bottom"
        bottom.physicsBody = SKPhysicsBody(edgeFrom: bottomLeft, to: bottomRight)
        addChild(bottom)
        
        let top = SKNode()
        top.name = "top"
        top.physicsBody = SKPhysicsBody(edgeFrom: topLeft, to: topRight)
        addChild(top)
        
        let left = SKNode()
        left.name = "left"
        left.physicsBody = SKPhysicsBody(edgeFrom: topLeft, to: bottomLeft)
        addChild(left)
        
        let right = SKNode()
        right.name = "right"
        right.physicsBody = SKPhysicsBody(edgeFrom: topRight, to: bottomRight)
        addChild(right)
        
//        bottom.physicsBody?.categoryBitMask = bottomCategory
//        top.physicsBody?.categoryBitMask = topCategory
//        right.physicsBody?.categoryBitMask = rightCategory
//        left.physicsBody?.categoryBitMask = leftCategory
        
//        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
//        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
//        alert.addAction(okayAction)
        

    }
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if started {
            ball.physicsBody?.applyImpulse(CGVector(dx: 200, dy: 200))
            started = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    
    override func update(_ currentTime: TimeInterval) {
    
    }
    
    func goal() {
        counter += 1
    }
}
