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

let leftBlock1Category: UInt32 = 0x1 << 8
let leftBlock2Category: UInt32 = 0x1 << 9
let leftBlock3Category: UInt32 = 0x1 << 10
let leftBlock4Category: UInt32 = 0x1 << 11
let rightBlock1Category: UInt32 = 0x1 << 12
let rightBlock2Category: UInt32 = 0x1 << 13
let rightBlock3Category: UInt32 = 0x1 << 14
let rightBlock4Category: UInt32 = 0x1 << 15

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
    
    var timer = Timer()
    var seconds = 0
    
    var leftCounter = 0
    var rightCounter = 0
    var leftLabel = SKLabelNode()
    var rightLabel = SKLabelNode()
    var timerNode = SKLabelNode()
    var started = false
    var selectedNodes:[UITouch:SKSpriteNode] = [:]
    var colorArray: Array = [UIColor.blue, UIColor.green, UIColor.cyan, UIColor.red]
    var vectorArray: Array = [CGVector(dx: 500, dy: 500), CGVector(dx: -500, dy: -500), CGVector(dx: -500, dy: 500), CGVector(dx: 500, dy: -500)]

    override func didMove(to view: SKView) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameScene.timerIncrease), userInfo: nil, repeats: true)
        physicsWorld.contactDelegate = self
        self.view?.isMultipleTouchEnabled = true
        
        leftLabel = SKLabelNode(text: "0")
        leftLabel.fontSize = 150.0
        leftLabel.position = CGPoint(x: -400, y: -35)
        addChild(leftLabel)
        rightLabel = SKLabelNode(text: "0")
        rightLabel.fontSize = 150.0
        rightLabel.position = CGPoint(x: 400, y: -35)
        addChild(rightLabel)
        timerNode = SKLabelNode(text: "00:00")
        timerNode.fontSize = 175.0
        //timerNode.fontName = "Courier New"
        timerNode.position = CGPoint(x: 0, y: 400)
        addChild(timerNode)
        
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
        leftBlock1.physicsBody?.categoryBitMask = leftBlock1Category
        leftBlock2.physicsBody?.categoryBitMask = leftBlock2Category
        leftBlock3.physicsBody?.categoryBitMask = leftBlock3Category
        leftBlock4.physicsBody?.categoryBitMask = leftBlock4Category
        rightBlock1.physicsBody?.categoryBitMask = rightBlock1Category
        rightBlock2.physicsBody?.categoryBitMask = rightBlock2Category
        rightBlock3.physicsBody?.categoryBitMask = rightBlock3Category
        rightBlock4.physicsBody?.categoryBitMask = rightBlock4Category
        ball.physicsBody?.categoryBitMask = ballCategory
        bottom.physicsBody?.categoryBitMask = bottomCategory
        top.physicsBody?.categoryBitMask = topCategory
        right.physicsBody?.categoryBitMask = rightCategory
        left.physicsBody?.categoryBitMask = leftCategory
        
        ball.physicsBody?.contactTestBitMask = bottomCategory|topCategory|leftCategory|rightCategory|paddleCategory|leftBlock1Category|leftBlock2Category|leftBlock3Category|leftBlock4Category|rightBlock1Category|rightBlock2Category|rightBlock3Category|rightBlock4Category
        leftPlayer.physicsBody?.contactTestBitMask = bottomCategory|topCategory|leftCategory|rightCategory
        rightPlayer.physicsBody?.contactTestBitMask = bottomCategory|topCategory|leftCategory|rightCategory
        
        let randomVectorIndex = Int(arc4random_uniform(UInt32(vectorArray.count)))
        if seconds == 0 {
            ball.physicsBody?.applyImpulse(vectorArray[randomVectorIndex])
        }
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
            if let node = selectedNodes[touch] {
                let xPosition = node.position.x
                let yPosition = location.y
                node.position = CGPoint(x: xPosition, y: yPosition) 
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
        if contact.bodyA.categoryBitMask == rightBlock1Category{
            colorPaddle(rightBlock1)
        }
        else if contact.bodyA.categoryBitMask == rightBlock2Category{
            colorPaddle(rightBlock2)
        }
        else if contact.bodyA.categoryBitMask == rightBlock3Category{
            colorPaddle(rightBlock3)
        }
        else if contact.bodyA.categoryBitMask == rightBlock4Category{
            colorPaddle(rightBlock4)
        }
        else if contact.bodyA.categoryBitMask == leftBlock1Category{
            colorPaddle(leftBlock1)
        }
        else if contact.bodyA.categoryBitMask == leftBlock2Category{
            colorPaddle(leftBlock2)
        }
        else if contact.bodyA.categoryBitMask == leftBlock3Category{
            colorPaddle(leftBlock3)
        }
        else if contact.bodyA.categoryBitMask == leftBlock4Category{
            colorPaddle(leftBlock4)
        }
        
        if contact.bodyA.categoryBitMask == leftCategory{
            rightCounter += 1
            rightLabel.text = "\(rightCounter)"
        }
        if contact.bodyA.categoryBitMask == rightCategory{
            leftCounter += 1
            leftLabel.text = "\(leftCounter)"
        }
        
        if leftCounter == 5{
            timerNode.text = "Left Player Wins"
            removeAllActions()
            ball.removeFromParent()
            timer.invalidate()
        }
        if rightCounter == 5{
            timerNode.text = "Right Player Wins"
            removeAllActions()
            ball.removeFromParent()
            timer.invalidate()
        }
        
//        if seconds == 180{
//            if leftCounter > rightCounter {
//                timerNode.text = "Left Player Wins"
//                removeAllActions()
//                ball.removeFromParent()
//                timer.invalidate()
//            }
//            if rightCounter > leftCounter {
//                timerNode.text = "Right Player Wins"
//                removeAllActions()
//                ball.removeFromParent()
//                timer.invalidate()
//            }
//        }
        
//        let randomVectorIndex = Int(arc4random_uniform(UInt32(vectorArray.count)))
//        if seconds == 0 {
//            ball.physicsBody?.applyImpulse(vectorArray[randomVectorIndex])
//        }
        
        if seconds == 10
        {
            ball.physicsBody?.velocity = CGVector(dx: ((ball.physicsBody?.velocity.dx)! * 1.1), dy: ((ball.physicsBody?.velocity.dy)! * 1.1))
        }
        if seconds == 20
        {
            ball.physicsBody?.velocity = CGVector(dx: ((ball.physicsBody?.velocity.dx)! * 1.1), dy: ((ball.physicsBody?.velocity.dy)! * 1.1))
        }
        if seconds == 30
        {
            ball.physicsBody?.velocity = CGVector(dx: ((ball.physicsBody?.velocity.dx)! * 1.1), dy: ((ball.physicsBody?.velocity.dy)! * 1.1))
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    @objc func timerIncrease(){
//        seconds -= 1
//        timerNode.text = timeString(time: TimeInterval(seconds))
//        if seconds == 0 {
//        seconds += 1
//        timerNode.text = timeString(time: TimeInterval(seconds))
//        }
        seconds += 1
        timerNode.text = timeString(time: TimeInterval(seconds))
    }
    
    func colorPaddle(_ node: SKSpriteNode){
        let randomIndex = Int(arc4random_uniform(UInt32(colorArray.count)))
        node.color = colorArray[randomIndex]
        if node.color == UIColor.red{
            node.removeAllActions()
            node.removeFromParent()
        }
    }
}
