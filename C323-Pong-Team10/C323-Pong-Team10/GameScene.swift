//  Jake Oliger     -  joliger@indiana.edu
//  Dilzat Muradil  -  dmuradil@indiana.edu
//
//  Pong for iOS
//  Submitted for C323 Mobile App Development on June 18th, 2021
//
//  GameScene.swift
//  C323-Pong-Team10
//
//  Created by Oliger, Jake on 6/10/21.
//

import SpriteKit

struct PhysicsCategory {
    static let none     : UInt32 = 0
    static let all      : UInt32 = UInt32.max
    static let paddle   : UInt32 = 0b1
    static let ball     : UInt32 = 0b10
}

class GameScene: SKScene {
    
    var viewController: GameViewController?
    
    var player: Player?
    var computer: ComputerPlayer?
    var ball: Ball?
    var scoreboard: Scoreboard?
    var needsReversing: Bool = false
    var ballVelocity: CGFloat = 100
    var requestedX: CGFloat = -1
    var sceneWidth: Int = 500
    var opponentScoreThreshold: CGFloat = 500
    var playerScoreThreshold: CGFloat = 0
    var gameMessage: SKLabelNode?
    
    override func didMove(to view: SKView) {
        let sceneWidth: Int = Int(view.frame.width)
        self.sceneWidth = sceneWidth
        let sceneHeight: Int = Int(view.frame.height)
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        self.player = Player(x: sceneWidth / 2, y: 100, sceneWidth: sceneWidth)
        self.opponentScoreThreshold = 50
        self.computer = ComputerPlayer(x: sceneWidth / 2, y: sceneHeight - 125, sceneWidth: sceneWidth)
        self.playerScoreThreshold = CGFloat(sceneHeight) - 75
        self.scoreboard = Scoreboard(topOfScene: sceneHeight - 30, width: sceneWidth, height: 60)
        self.ball = Ball(x: sceneWidth / 2, y: sceneHeight / 2, speed: self.ballVelocity)
        
        self.gameMessage = SKLabelNode(text: "Tap to play!")
        self.gameMessage?.fontName = "Arial"
        self.gameMessage?.position.x = view.frame.width / 2
        self.gameMessage?.position.y = view.frame.height / 2 + (view.frame.height / 6)
        
        if let gm = self.gameMessage { addChild(gm); }
        if let p = self.player { addChild(p.node); }
        if let c = self.computer { addChild(c.node); }
        if let s = self.scoreboard { addChild(s.node); }
        if let b = self.ball {
            addChild(b.node);
            b.reset()
        }
    }
    
    func pause() {
        self.view?.isPaused = true
        self.gameMessage?.isHidden = false
    }
    
    func unpause() {
        self.view?.isPaused = false
        self.gameMessage?.isHidden = true
    }
    
    func endGame(message: String) {
        self.gameMessage?.text = message
        self.pause()
        self.viewController?.gameIsStarted = false
        self.restartGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.handleTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        self.handleTouches(touches)
    }
    
    func handleTouches(_ touches: Set<UITouch>) {
        if self.viewController?.gameIsStarted == false {
            self.viewController?.gameIsStarted = true
            self.scoreboard?.reset()
            self.unpause()
        }
        
        for touch in touches {
            self.requestedX = touch.location(in: self).x
        }
    }
    
    func restartGame() {
        if let p = self.player,
           let c = self.computer,
           let b = self.ball,
           let sc = self.scoreboard {
            p.reset()
            c.reset()
            b.reset()
            sc.reset()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if self.viewController?.gameIsStarted == false {
            self.pause()
            return
        }
        
        // Set player position to the latest touch event location
        if let p = self.player {
            if self.requestedX > 0 {
                p.moveTo(attemptedX: self.requestedX)
            }
            p.update()
        }
        
        if let c = self.computer {
            c.update()
        }
        
        // Maintain the ball velocity at +/- 100,
        // reverse y-velocity if there's been a paddle collision,
        // reverse x-velocity if there's been a wall collision,
        // handle scoring based on ball position
        // Optional TODO: Refactor most of this into the Ball class
        if let b = self.ball, let pb = b.node.physicsBody {
            // Handles flag set by the SKPhysicsContactDelegate
            if (self.needsReversing) {
                pb.velocity.dy = -pb.velocity.dy;
                self.needsReversing = false;
            }
            
            // Maintains a constant speed for the ball
            b.maintainSpeed()

            // Manage wall hits
            let hitLeftWall = Int(b.node.position.x) - b.width / 2 < 0
            let hitRightWall = Int(b.node.position.x) + b.width / 2 > self.sceneWidth
            if (hitLeftWall || hitRightWall) {
                pb.velocity.dx = -pb.velocity.dx
            }
            
            // Manage scores
            if b.node.position.y < self.opponentScoreThreshold {
                // Opponent has scored
                self.scoreboard?.opponentScored()
                b.reset()
            } else if b.node.position.y > self.playerScoreThreshold {
                // Player has scored
                self.scoreboard?.playerScored()
                b.reset()
            }
        }
        
        // Handle scoreboard
        self.scoreboard?.update()
        
        if let s = self.scoreboard, let vc = self.viewController {
            if s.playerPoints > s.opponentPoints && s.playerPoints >= 10 {
                vc.playerHasWon(time_ms: s.getTimeMS())
            } else if s.opponentPoints > s.playerPoints && s.opponentPoints >= 10 {
                vc.computerHasWon()
            }
        }
    }
}

extension GameScene : SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let isBallContact = contact.bodyA.node?.name == "ball" || contact.bodyB.node?.name == "ball"
        var otherContact: String = ""
        
        if isBallContact {
            if contact.bodyA.node?.name == "player" || contact.bodyB.node?.name == "player" {
                otherContact = "player"
            } else {
                otherContact = "computer"
            }
            reverseBall()
            if let pb = self.ball?.node.physicsBody {
                pb.velocity.dx += (otherContact == "player" ? self.player?.getSpeed() : self.computer?.getSpeed()) ?? 0.0
            }
                
        }
        
        if (otherContact == "player") {
            if let b = self.ball, let c = self.computer, let s = self.viewController?.mySettings {
                c.moveToPredictedBallPosition(ball: b, sceneWidth: CGFloat(self.sceneWidth), difficulty: s.difficulty)
            }
        }
        
        if (otherContact == "computer") {
            if let settings = self.viewController?.mySettings, let c = self.computer {
                if settings.difficulty == Difficulty.hard {
                    c.moveToCenter(sceneWidth: CGFloat(self.sceneWidth))
                }
            }
        }
        
    }
    
    func reverseBall() {
        self.needsReversing = true;
    }
}
