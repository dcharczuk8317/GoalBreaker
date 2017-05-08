//
//  GameScene.swift
//  GoalBreaker
//
//  Created by student3 on 5/1/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit

let ballCategory: UInt32 = 0x1 << 0
let bottomCategory: UInt32 = 0x1 << 1
let topCategory: UInt32 = 0x1 << 2
let leftCategory: UInt32 = 0x1 << 3
let rightCategory: UInt32 = 0x1 << 4
let paddleCategory: UInt32 = 0x1 << 5
let blockCategory: UInt32 = 0x1 << 6

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
    var leftPlayer = SKSpriteNode()
    var rightPlayer = SKSpriteNode()
    
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
        leftPlayer = self.childNode(withName: "leftPlayer") as! SKSpriteNode
        rightPlayer = self.childNode(withName: "rightPlayer") as! SKSpriteNode
        leftBlock1 = self.childNode(withName: "leftBlock1") as! SKSpriteNode
        leftBlock2 = self.childNode(withName: "leftBlock2") as! SKSpriteNode
        leftBlock3 = self.childNode(withName: "leftBlock3") as! SKSpriteNode
        leftBlock4 = self.childNode(withName: "leftBlock4") as! SKSpriteNode
        rightBlock1 = self.childNode(withName: "rightBlock1") as! SKSpriteNode
        rightBlock2 = self.childNode(withName: "rightBlock2") as! SKSpriteNode
        rightBlock3 = self.childNode(withName: "rightBlock3") as! SKSpriteNode
        rightBlock4 = self.childNode(withName: "rightBlock4") as! SKSpriteNode
    
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
        

        
        
        leftPlayer.physicsBody?.categoryBitMask = paddleCategory
        rightPlayer.physicsBody?.categoryBitMask = paddleCategory
        leftBlock1.physicsBody?.categoryBitMask = blockCategory
        leftBlock2.physicsBody?.categoryBitMask = blockCategory
        leftBlock3.physicsBody?.categoryBitMask = blockCategory
        leftBlock4.physicsBody?.categoryBitMask = blockCategory
        rightBlock1.physicsBody?.categoryBitMask = blockCategory
        rightBlock2.physicsBody?.categoryBitMask = blockCategory
        rightBlock3.physicsBody?.categoryBitMask = blockCategory
        rightBlock4.physicsBody?.categoryBitMask = blockCategory
        ball.physicsBody?.categoryBitMask = ballCategory
        bottom.physicsBody?.categoryBitMask = bottomCategory
        top.physicsBody?.categoryBitMask = topCategory
        right.physicsBody?.categoryBitMask = rightCategory
        left.physicsBody?.categoryBitMask = leftCategory
        
        ball.physicsBody?.contactTestBitMask = bottomCategory|topCategory|leftCategory|rightCategory|paddleCategory|blockCategory

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
//        if started {
//            ball.physicsBody?.applyImpulse(CGVector(dx: 200, dy: 200))
//            started = true
//        }
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == blockCategory{
            counter += 1
            label.text = "\(counter)"
        }
    }
    
    func restartGame(){
        if counter == 5{
            
            let alert = UIAlertController(title: "Game Over", message: "Do you want to restart?", preferredStyle: UIAlertControllerStyle.alert)
            let YesAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            alert.addAction(YesAction)
            
            

            
        }
    }
    
//    func goal() {
//        counter += 1
//    }
}
