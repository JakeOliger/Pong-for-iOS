//  Jake Oliger     -  joliger@indiana.edu
//  Dilzat Muradil  -  dmuradil@indiana.edu
//
//  Pong for iOS
//  Submitted for C323 Mobile App Development on June 18th, 2021
//
//  Scoreboard.swift
//  C323-Pong-Team10
//
//  Created by Oliger, Jake on 6/12/21.
//

import SpriteKit
import Foundation

class Scoreboard {
    var playerPoints: Int = 0
    var opponentPoints: Int = 0
    let node: SKShapeNode
    let playerScoreLabel = SKLabelNode(text: "0")
    let playerNameLabel = SKLabelNode(text: "You")
    let opponentScoreLabel = SKLabelNode(text: "0")
    let opponentNameLabel = SKLabelNode(text: "Computer")
    let timeLabel = SKLabelNode(text: "0:00.0")
    var startTime: DispatchTime
    
    init(topOfScene: Int, width: Int, height: Int) {
        // Start the clock!
        self.startTime = DispatchTime.now()
        
        // Create the scoreboard node, which is really just a background shape
        // that acts as a parent for the other scoreboard elements
        self.node = SKShapeNode(rectOf: CGSize(width: width, height: height))
        self.node.position = CGPoint(x: CGFloat(width / 2), y: CGFloat(topOfScene - height / 2))
        self.node.fillColor = UIColor(red: 0.23, green: 0.23, blue: 0.23, alpha: 0.25)
        self.node.strokeColor = self.node.fillColor
        
        // Position and define the labels
        playerScoreLabel.position = CGPoint(x: -width / 2 + 50, y: -height / 6)
        playerNameLabel.position = CGPoint(x: -width / 2 + 50, y: -height / 2 + 2)
        playerNameLabel.fontSize = CGFloat(14)
        opponentScoreLabel.position = CGPoint(x: width / 2 - 50, y: -height / 6)
        opponentNameLabel.position = CGPoint(x: width / 2 - 50, y: -height / 2 + 2)
        opponentNameLabel.fontSize = CGFloat(14)
        timeLabel.position = CGPoint(x: 0, y: -height / 5)
        timeLabel.fontSize = CGFloat(24)
        playerNameLabel.fontName = "Arial"
        opponentNameLabel.fontName = "Arial"
        
        // Add all the child nodes to the scoreboard node
        self.node.addChild(playerScoreLabel)
        self.node.addChild(playerNameLabel)
        self.node.addChild(opponentScoreLabel)
        self.node.addChild(opponentNameLabel)
        self.node.addChild(timeLabel)
    }
    
    func playerScored() {
        self.playerPoints += 1
        self.updateLabels()
    }
    
    func opponentScored() {
        self.opponentPoints += 1
        self.updateLabels()
    }
    
    func updateLabels() {
        self.playerScoreLabel.text = String(self.playerPoints)
        self.opponentScoreLabel.text = String(self.opponentPoints)
    }
    
    func reset() {
        self.playerPoints = 0
        self.opponentPoints = 0
        self.updateLabels()
        self.startTime = DispatchTime.now()
    }
    
    func update() {
        let now = DispatchTime.now()
        let elapsedTime = Double(now.uptimeNanoseconds - self.startTime.uptimeNanoseconds) / 1_000_000_000
        let minutes = Int(floor(elapsedTime / 60))
        let seconds = Int(floor(elapsedTime - Double(minutes) * 60))
        let milliseconds = Int((round((elapsedTime - Double(seconds)) * 10) / 10) * 10)
        self.timeLabel.text = String(format: "%01d:%02d.%01d", minutes, seconds, milliseconds)
    }
    
    func getTimeMS() -> Int {
        let now = DispatchTime.now()
        let elapsedTime = Double(now.uptimeNanoseconds - self.startTime.uptimeNanoseconds) / 1_000_000
        let milliseconds = Int((Double(elapsedTime) * 1000 / 1000))
        return milliseconds
    }
}
