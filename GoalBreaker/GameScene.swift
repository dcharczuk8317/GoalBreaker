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
let leftBlockCategory: UInt32 = 0x1 << 6
let rightBlockCategory: UInt32 = 0x1 << 7

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
    
    var timer = 0
    var leftCounter = 0
    var rightCounter = 0
    var leftLabel = SKLabelNode()
    var rightLabel = SKLabelNode()
    var started = false
    var selectedNodes:[UITouch:SKSpriteNode] = [:]
    

    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        self.view?.isMultipleTouchEnabled = true
        
        //var initialVelocity = ball.physicsBody?.applyImpulse(CGVector(dx: 700, dy: 700))
        
        leftLabel = SKLabelNode(text: "0")
        leftLabel.fontSize = 150.0
        leftLabel.position = CGPoint(x: 200, y: -35)
        addChild(leftLabel)
        rightLabel = SKLabelNode(text: "0")
        rightLabel.fontSize = 150.0
        rightLabel.position = CGPoint(x: -200, y: -35)
        addChild(rightLabel)
        
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
        
        leftPlayer.physicsBody?.categoryBitMask = paddleCategory
        rightPlayer.physicsBody?.categoryBitMask = paddleCategory
        leftBlock1.physicsBody?.categoryBitMask = leftBlockCategory
        leftBlock2.physicsBody?.categoryBitMask = leftBlockCategory
        leftBlock3.physicsBody?.categoryBitMask = leftBlockCategory
        leftBlock4.physicsBody?.categoryBitMask = leftBlockCategory
        rightBlock1.physicsBody?.categoryBitMask = rightBlockCategory
        rightBlock2.physicsBody?.categoryBitMask = rightBlockCategory
        rightBlock3.physicsBody?.categoryBitMask = rightBlockCategory
        rightBlock4.physicsBody?.categoryBitMask = rightBlockCategory
        ball.physicsBody?.categoryBitMask = ballCategory
        bottom.physicsBody?.categoryBitMask = bottomCategory
        top.physicsBody?.categoryBitMask = topCategory
        right.physicsBody?.categoryBitMask = rightCategory
        left.physicsBody?.categoryBitMask = leftCategory
        
        ball.physicsBody?.contactTestBitMask = bottomCategory|topCategory|leftCategory|rightCategory|paddleCategory|leftBlockCategory|rightBlockCategory

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            if let node = self.atPoint(location) as? SKSpriteNode {
                if (node.name == "leftPlayer") {
                    selectedNodes[touch] = node
                }
                if (node.name == "rightPlayer") {
                    selectedNodes[touch] = node
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in:self)
            // Update the position of the sprites
            if let node = selectedNodes[touch] {
                node.position = location
                
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if selectedNodes[touch] != nil {
                selectedNodes[touch] = nil
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == leftBlockCategory{
            leftCounter += 1
            leftLabel.text = "\(leftCounter)"
        }
        if contact.bodyA.categoryBitMask == rightBlockCategory{
            rightCounter += 1
            rightLabel.text = "\(rightCounter)"
        }
    }
    
    func restartGameLeft(){
        if leftCounter == 5{
            let alert = UIAlertController(title: "Game Over", message: "Left Player Wins", preferredStyle: UIAlertControllerStyle.alert)
            let RestartAction = UIAlertAction(title: "Restart", style: .default, handler: nil)
            alert.addAction(RestartAction)
        }
        return restartGameLeft()
    }
        func restartGameRight(){
        if rightCounter == 5{
            let alert = UIAlertController(title: "Game Over", message: "Right Player Wins", preferredStyle: UIAlertControllerStyle.alert)
            let RestartAction = UIAlertAction(title: "Restart", style: .default, handler: nil)
            alert.addAction(RestartAction)
        }
        return restartGameRight()
    }
//    func speedUpGame{
//        if leftCounter == 1{
//            initialVelocity.CGVector.x += 100
//        }
//    }
}
