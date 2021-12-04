//  Jake Oliger     -  joliger@indiana.edu
//  Dilzat Muradil  -  dmuradil@indiana.edu
//
//  Pong for iOS
//  Submitted for C323 Mobile App Development on June 18th, 2021
//
//  ComputerPlayer.swift
//  C323-Pong-Team10
//
//  Created by Oliger, Jake on 6/10/21.
//

import SpriteKit
import Darwin

class ComputerPlayer : Paddle {
    
    override init(x: Int, y: Int, sceneWidth: Int) {
        super.init(x: x, y: y, sceneWidth: sceneWidth)
        self.node.name = "computer"
    }
    
    // TODO: Fix bug where computer paddle goes a bit too far for high-angle hits
    func moveToPredictedBallPosition(ball: Ball, sceneWidth: CGFloat, difficulty: Difficulty) {
        self.node.removeAllActions()
        // Determine new target x
        if let pb = ball.node.physicsBody {
            let speed: CGFloat = difficulty == Difficulty.easy ? 30 : 50
            let theta = atan(Double(ball.speed) / Double(pb.velocity.dx))
            var targetX = CGFloat(Double(ball.node.position.x) + Double(self.node.position.y - ball.node.position.y) / Double(tan(theta)))
            let truncation = abs(targetX.truncatingRemainder(dividingBy: sceneWidth))
            
            if targetX < sceneWidth {
                targetX = truncation
            } else {
                targetX = sceneWidth - truncation
            }
            
            // Determine speed
            let paddleSpeed: CGFloat = (abs(self.node.position.x - targetX) / speed)
            
            self.node.run(SKAction.moveTo(x: targetX, duration: TimeInterval(paddleSpeed)))
        }
    }
    
    // Strategic move to reduce average distance needed to reach the ball
    func moveToCenter(sceneWidth: CGFloat) {
        self.node.removeAllActions()
        let targetX = sceneWidth / 2
        let paddleSpeed: CGFloat = (abs(self.node.position.x - targetX) / 50)
        self.node.run(SKAction.moveTo(x: targetX, duration: TimeInterval(paddleSpeed)))
    }
}
