//  Jake Oliger     -  joliger@indiana.edu
//  Dilzat Muradil  -  dmuradil@indiana.edu
//
//  Pong for iOS
//  Submitted for C323 Mobile App Development on June 18th, 2021
//
//  Ball.swift
//  C323-Pong-Team10
//
//  Created by Oliger, Jake on 6/10/21.
//

import SpriteKit

class Ball {
    var mySettingView = SettingsViewController()
    
    let node = SKShapeNode(rectOf: CGSize(width: 5, height: 5))
    var width: Int = 5
    let initialX: CGFloat
    let initialY: CGFloat
    let speed: CGFloat
    
    init(x: Int, y: Int, speed: CGFloat) {
        // Set attributes for the Shape Node
        self.node.name = "ball"
        self.node.position = CGPoint(x: x, y: y)
        self.initialX = CGFloat(x)
        self.initialY = CGFloat(y)
        self.speed = speed
        
        // Set attributes for the physics body
        self.node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.width, height: 5))
        self.node.physicsBody?.isDynamic = true
        self.node.physicsBody?.categoryBitMask = PhysicsCategory.ball
        self.node.physicsBody?.contactTestBitMask = PhysicsCategory.paddle
        self.node.physicsBody?.collisionBitMask = PhysicsCategory.paddle
        self.node.physicsBody?.friction = CGFloat(0)
        self.node.physicsBody?.mass = CGFloat(0)
    }
    
    func reset() {
        if let pb = self.node.physicsBody {
            self.node.position.x = self.initialX
            self.node.position.y = self.initialY
            pb.velocity = CGVector(dx: 0, dy: 0)
            pb.applyImpulse(CGVector(dx: CGFloat.random(in: -100...100), dy: -self.speed))
        }
    }
    
    func maintainSpeed() {
        if let pb = self.node.physicsBody {
            if pb.velocity.dy < 0 {
                pb.velocity.dy = -self.speed
            } else {
                pb.velocity.dy = self.speed
            }
        }
    }
}
