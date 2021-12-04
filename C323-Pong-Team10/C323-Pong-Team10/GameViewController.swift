//  Jake Oliger     -  joliger@indiana.edu
//  Dilzat Muradil  -  dmuradil@indiana.edu
//
//  Pong for iOS
//  Submitted for C323 Mobile App Development on June 18th, 2021
//
//  GameViewController.swift
//  C323-Pong-Team10
//
//  Created by Oliger, Jake on 6/10/21.
//

import SpriteKit

class GameViewController: UIViewController {
    
    var myAppDelegate: AppDelegate?
    var mySettings: SettingsModel?
    var myHighscores: HighscoresModel?
    var scene: GameScene?
    var gameIsStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myAppDelegate = UIApplication.shared.delegate as? AppDelegate
        self.mySettings = self.myAppDelegate?.settings
        self.mySettings?.load()
        self.myHighscores = self.myAppDelegate?.highscores
        self.scene = GameScene(size: view.frame.size)
        self.scene?.viewController = self
        self.updateColor()
        let skView = view as! SKView
        skView.presentScene(self.scene)
    }
    
    // Updates colors based on the settings before the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scene?.unpause()
        
        self.updateColor()
    }
    
    func updateColor() {
        if let s = self.scene,
           let b = s.ball,
           let settings = self.mySettings,
           let p = s.player,
           let c = s.computer {
            b.node.fillColor = settings.fgColor
            b.node.strokeColor = settings.fgColor
            p.node.fillColor = settings.fgColor
            p.node.strokeColor = settings.fgColor
            c.node.fillColor = settings.fgColor
            c.node.strokeColor = settings.fgColor
            s.backgroundColor = settings.bgColor
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.scene?.view?.isPaused = true
    }
    
    // Lets the view controller know that the player has won,
    // how many milliseconds it took to win, and what difficulty they were playing on
    func playerHasWon(time_ms: Int) {
        if let settings = self.mySettings {
            if !settings.name.isEmpty {
                self.myHighscores?.save(name: settings.name, time_ms: time_ms, difficulty: settings.difficulty)
                print("\(settings.name) won in \(Double(time_ms) / 1000) s playing on \(settings.difficulty)")
            }
        }
        self.scene?.endGame(message: "You win!")
    }
    
    func computerHasWon() {
        self.scene?.endGame(message: "You lose!")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
