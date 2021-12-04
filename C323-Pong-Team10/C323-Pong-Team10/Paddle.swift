//  Jake Oliger     -  joliger@indiana.edu
//  Dilzat Muradil  -  dmuradil@indiana.edu
//
//  Pong for iOS
//  Submitted for C323 Mobile App Development on June 18th, 2021
//
//  Paddle.swift
//  C323-Pong-Team10
//
//  Created by Oliger, Jake on 6/10/21.
//

import SpriteKit

class Paddle {
    
    let node = SKShapeNode(rectOf: CGSize(width: 50, height: 5))
    let sceneWidth: Int
    let y: CGFloat
    let initialX: CGFloat
    var previousPositions: [CGFloat] = []
    
    init(x: Int, y: Int, sceneWidth: Int) {
        self.sceneWidth = sceneWidth
        self.y = CGFloat(y)
        self.initialX = CGFloat(x)
        
        // Set attributes for the Shape Node
        self.node.name = "paddle"
        self.node.position = CGPoint(x: x, y: y)
        
        // Set attributes for the physics body
        self.node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 5))
        self.node.physicsBody?.isDynamic = true
        self.node.physicsBody?.categoryBitMask = PhysicsCategory.paddle
        self.node.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        self.node.physicsBody?.collisionBitMask = PhysicsCategory.ball
        self.node.physicsBody?.mass = CGFloat(99999)
        
        // Lock to y coordinate, lock rotation
        self.node.constraints = [
            SKConstraint.positionY(SKRange(constantValue: CGFloat(self.y))),
            SKConstraint.zRotation(SKRange(constantValue: CGFloat(0))),
            SKConstraint.positionX(SKRange(lowerLimit: 25, upperLimit: CGFloat(sceneWidth - 25)))
        ]
    }
    
    // Optional TODO: Use an animated moveTo to make the paddle movement more fluid
    func moveTo(attemptedX: CGFloat) {
        var x = attemptedX
        if x < 25 { x = 25 }
        if x > CGFloat(sceneWidth) - 25 { x = CGFloat(sceneWidth) - 25 }
        self.node.position = CGPoint(x: x, y: self.y)
    }
    
    func update() {
        self.previousPositions.append(self.node.position.x)
        if (self.previousPositions.count >= 20) {
            self.previousPositions.removeFirst()
        }
    }
    
    func getSpeed() -> CGFloat {
        var speed: CGFloat = 0.0
        let end = self.previousPositions.count
        let start = end / 2
        for i in start..<end {
            speed += self.previousPositions[i] - self.previousPositions[i - start]
        }
        return speed / CGFloat(self.previousPositions.count)
    }
    
    func reset() {
        self.moveTo(attemptedX: self.initialX)
    }
}
