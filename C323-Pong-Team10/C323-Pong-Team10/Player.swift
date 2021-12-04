//  Jake Oliger     -  joliger@indiana.edu
//  Dilzat Muradil  -  dmuradil@indiana.edu
//
//  Pong for iOS
//  Submitted for C323 Mobile App Development on June 18th, 2021
//
//  Player.swift
//  C323-Pong-Team10
//
//  Created by Oliger, Jake on 6/10/21.
//

import Foundation

class Player : Paddle {
    override init(x: Int, y: Int, sceneWidth: Int) {
        super.init(x: x, y: y, sceneWidth: sceneWidth)
        self.node.name = "player"
    }
    
}
