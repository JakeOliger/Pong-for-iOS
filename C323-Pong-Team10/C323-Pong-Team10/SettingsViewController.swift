//  Jake Oliger     -  joliger@indiana.edu
//  Dilzat Muradil  -  dmuradil@indiana.edu
//
//  Pong for iOS
//  Submitted for C323 Mobile App Development on June 18th, 2021
//
//  SettingsViewController.swift
//  C323-Pong-Team10
//
//  Created by Oliger, Jake on 6/10/21.
//

import UIKit

class SettingsViewController: UIViewController
{
    @IBOutlet weak var myNameTextField: UITextField!
    var myAppDelegate: AppDelegate?
    var mySettings: SettingsModel?

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.myAppDelegate = UIApplication.shared.delegate as? AppDelegate

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.mySettings = appDelegate.settings
            self.mySettings?.load()
            self.setButtonColor()
        }
        
        myNameTextField.text = self.mySettings?.name
        
        if let s = self.mySettings {
            switch (s.difficulty) {
            case Difficulty.easy:
                self.myEasyLevelLabel.backgroundColor = UIColor.red
                self.myNormalLevelLabel.backgroundColor = UIColor.systemGray5
                self.myHardLevelLabel.backgroundColor = UIColor.systemGray5
                break;
            case Difficulty.normal:
                self.myEasyLevelLabel.backgroundColor = UIColor.systemGray5
                self.myNormalLevelLabel.backgroundColor = UIColor.red
                self.myHardLevelLabel.backgroundColor = UIColor.systemGray5
                break;
            case Difficulty.hard:
                self.myEasyLevelLabel.backgroundColor = UIColor.systemGray5
                self.myNormalLevelLabel.backgroundColor = UIColor.systemGray5
                self.myHardLevelLabel.backgroundColor = UIColor.red
                break;
            }
        } else {
            self.myEasyLevelLabel.backgroundColor = UIColor.systemGray5
            self.myNormalLevelLabel.backgroundColor = UIColor.red
            self.myHardLevelLabel.backgroundColor = UIColor.systemGray5
        }
    }
    
    @IBOutlet weak var myEasyLevelLabel: UIButton!
    @IBOutlet weak var myNormalLevelLabel: UIButton!
    @IBOutlet weak var myHardLevelLabel: UIButton!
    
    @IBOutlet weak var myBlackAndWhiteButtonOutlet: UIButton!
    @IBOutlet weak var myRedAndOrangeButtonOutlet: UIButton!
    @IBOutlet weak var myBlueAndTealButtonOutlet: UIButton!
    @IBOutlet weak var myGreenAndBrownButonOutlet: UIButton!
    @IBOutlet weak var myBrownAndYellowButtonOutlet: UIButton!
    @IBOutlet weak var myGreenAndGrayButtonOutlet: UIButton!
    @IBOutlet weak var myPurpleAndRedButtonOutlet: UIButton!
    @IBOutlet weak var myBrownAndGreenButtonOutlet: UIButton!
    
    // TODO: Connect text field and update name from it when the user finishes typing
    
    
    //-------------------- Name Setting --------------------
    
    
    //func getMyName() -> String
    //{
    //    return ""
    //}
    
    @IBAction func myEntryCompleteButton(_ sender: Any)
    {
        self.mySettings?.setName(self.myNameTextField.text!)
    }
    
    
    
    
    //-------------------- Difficulty Setting --------------------
    // Use following three buttons to decide the level of game,
    // When the user click one of the button, that button will send value to
    // change the game difficulity to the getDifficulty() method and the
    // getDifficulity() can return that value to the method that decide the actual
    // difficulity on the other .swift file.
    @IBAction func myEasyLevelButton(_ sender: Any)
    {
        self.myEasyLevelLabel.backgroundColor = UIColor.red
        self.myNormalLevelLabel.backgroundColor = UIColor.systemGray5
        self.myHardLevelLabel.backgroundColor = UIColor.systemGray5
        self.mySettings?.difficulty = Difficulty.easy
    }
    
    @IBAction func myNormalLevelButton(_ sender: Any)
    {
        self.myNormalLevelLabel.backgroundColor = UIColor.red
        self.myEasyLevelLabel.backgroundColor = UIColor.systemGray5
        self.myHardLevelLabel.backgroundColor = UIColor.systemGray5
        self.mySettings?.difficulty = Difficulty.normal
    }
    
    @IBAction func myHardLevelButton(_ sender: Any)
    {
        self.myHardLevelLabel.backgroundColor = UIColor.red
        self.myEasyLevelLabel.backgroundColor = UIColor.systemGray5
        self.myNormalLevelLabel.backgroundColor = UIColor.systemGray5
        self.mySettings?.difficulty = Difficulty.hard
    }
    
    //-------------------- Color Setting --------------------
    
    @IBAction func myColorOptionBlackAndWhiteButton(_ sender: Any)
    {
        self.mySettings?.setBackground(UIColor.black)
        self.mySettings?.setForeground(UIColor.white)
    }
    
    @IBAction func myColorOptionRedAndOrangeButton(_ sender: Any)
    {
        self.mySettings?.setBackground(UIColor.red)
        self.mySettings?.setForeground(UIColor.orange)
    }
    
    @IBAction func myColorOptionBlueAndTealButton(_ sender: Any)
    {
        self.mySettings?.setBackground(UIColor.blue)
        self.mySettings?.setForeground(UIColor.systemTeal)
    }
    
    @IBAction func myColorOptionGreenAndBrownButton(_ sender: Any)
    {
        self.mySettings?.setBackground(UIColor.green)
        self.mySettings?.setForeground(UIColor.brown)
    }
    
    @IBAction func myColorOptionBrownAndYellowButton(_ sender: Any)
    {
        self.mySettings?.setBackground(UIColor.brown)
        self.mySettings?.setForeground(UIColor.yellow)
    }
    
    @IBAction func myColorOptionEmeraldAndGrayButton(_ sender: Any)
    {
        
        self.mySettings?.setBackground(UIColor.green)
        self.mySettings?.setForeground(UIColor.gray)
    }
    
    @IBAction func myColorOptionPurpleAndRedButton(_ sender: Any)
    {
        self.mySettings?.setBackground(UIColor.purple)
        self.mySettings?.setForeground(UIColor.red)
    }
    
    @IBAction func myColorOptionBrownAndGreenButton(_ sender: Any)
    {
        self.mySettings?.setBackground(UIColor.brown)
        self.mySettings?.setForeground(UIColor.green)
    }
    
    
    func setButtonColor()
    {
        //-------------------- Black And White --------------------
        let blackAndWhiteLayer : CAGradientLayer = CAGradientLayer()
        blackAndWhiteLayer.frame = myBlackAndWhiteButtonOutlet.bounds
        blackAndWhiteLayer.colors =
            [
                UIColor.black.cgColor,
                UIColor.black.cgColor,
                UIColor.white.cgColor,
                UIColor.white.cgColor
            ]
        
        blackAndWhiteLayer.locations = [0, 0.5, 0.5, 1.0]
        
        blackAndWhiteLayer.startPoint = CGPoint(x:0, y:0)
        blackAndWhiteLayer.endPoint = CGPoint(x: 1, y: 1)
        
        myBlackAndWhiteButtonOutlet.layer.insertSublayer(blackAndWhiteLayer, at: 0)
        
        
        //-------------------- Red And Orange --------------------
        let redAndOrangeLayer : CAGradientLayer = CAGradientLayer()
        redAndOrangeLayer.frame = myRedAndOrangeButtonOutlet.bounds
        redAndOrangeLayer.colors =
            [
                UIColor.red.cgColor,
                UIColor.red.cgColor,
                UIColor.orange.cgColor,
                UIColor.orange.cgColor
            ]
    
        redAndOrangeLayer.locations  = [0, 0.5, 0.5, 1.0]
        redAndOrangeLayer.startPoint = CGPoint(x:0, y:0)
        redAndOrangeLayer.endPoint = CGPoint(x: 1, y: 1)
        
        myRedAndOrangeButtonOutlet.layer.insertSublayer(redAndOrangeLayer, at: 0)
        
        
        //-------------------- Blue And Teal --------------------
        let blueAndTealLayer : CAGradientLayer = CAGradientLayer()
        blueAndTealLayer.frame = myBlueAndTealButtonOutlet.bounds
        blueAndTealLayer.colors =
            [
                UIColor.blue.cgColor,
                UIColor.blue.cgColor,
                UIColor.systemTeal.cgColor,
                UIColor.systemTeal.cgColor
            ]
        
        blueAndTealLayer.locations = [0, 0.5, 0.5, 1.0]
        blueAndTealLayer.startPoint = CGPoint(x:0, y:0)
        blueAndTealLayer.endPoint = CGPoint(x: 1, y: 1)
        
        myBlueAndTealButtonOutlet.layer.insertSublayer(blueAndTealLayer, at: 0)
        
        
        //-------------------- Green And Brown --------------------
        let greenAndBrownLayer : CAGradientLayer = CAGradientLayer()
        greenAndBrownLayer.frame = myGreenAndBrownButonOutlet.bounds
        greenAndBrownLayer.colors =
            [
                UIColor.green.cgColor,
                UIColor.green.cgColor,
                UIColor.brown.cgColor,
                UIColor.brown.cgColor
            ]
        
        greenAndBrownLayer.locations = [0, 0.5, 0.5, 1.0]
        greenAndBrownLayer.startPoint = CGPoint(x:0, y:0)
        greenAndBrownLayer.endPoint = CGPoint(x: 1, y: 1)
        
        myGreenAndBrownButonOutlet.layer.insertSublayer(greenAndBrownLayer, at: 0)
        
        
        //-------------------- Brown And Yellow --------------------
        let brownAndYellowLayer : CAGradientLayer = CAGradientLayer()
        brownAndYellowLayer.frame = myBrownAndYellowButtonOutlet.bounds
        brownAndYellowLayer.colors =
            [
                UIColor.brown.cgColor,
                UIColor.brown.cgColor,
                UIColor.yellow.cgColor,
                UIColor.yellow.cgColor
            ]
        
        brownAndYellowLayer.locations = [0, 0.5, 0.5, 1.0]
        brownAndYellowLayer.startPoint = CGPoint(x:0, y:0)
        brownAndYellowLayer.endPoint = CGPoint(x: 1, y: 1)
        
        myBrownAndYellowButtonOutlet.layer.insertSublayer(brownAndYellowLayer, at: 0)
        
        
        //-------------------- Green And Gray --------------------
        let emeraldAndGrayLayer : CAGradientLayer = CAGradientLayer()
        emeraldAndGrayLayer.frame = myGreenAndGrayButtonOutlet.bounds
        emeraldAndGrayLayer.colors =
            [
                UIColor.green.cgColor,
                UIColor.green.cgColor,
                UIColor.gray.cgColor,
                UIColor.gray.cgColor
            ]
        
        emeraldAndGrayLayer.locations = [0, 0.5, 0.5, 1.0]
        emeraldAndGrayLayer.startPoint = CGPoint(x:0, y:0)
        emeraldAndGrayLayer.endPoint = CGPoint(x: 1, y: 1)
        
        myGreenAndGrayButtonOutlet.layer.insertSublayer(emeraldAndGrayLayer, at: 0)
        
        
        //-------------------- Purple And Red --------------------
        let purpleAndRedLayer : CAGradientLayer = CAGradientLayer()
        purpleAndRedLayer.frame = myPurpleAndRedButtonOutlet.bounds
        purpleAndRedLayer.colors =
            [
                UIColor.purple.cgColor,
                UIColor.purple.cgColor,
                UIColor.red.cgColor,
                UIColor.red.cgColor
            ]
        
        purpleAndRedLayer.locations = [0, 0.5, 0.5, 1.0]
        purpleAndRedLayer.startPoint = CGPoint(x:0, y:0)
        purpleAndRedLayer.endPoint = CGPoint(x: 1, y: 1)
        
        myPurpleAndRedButtonOutlet.layer.insertSublayer(purpleAndRedLayer, at: 0)
        
        
        //-------------------- Brown And Green --------------------
        let brownAndGreenLayer : CAGradientLayer = CAGradientLayer()
        brownAndGreenLayer.frame = myBrownAndGreenButtonOutlet.bounds
        brownAndGreenLayer.colors =
            [
                UIColor.brown.cgColor,
                UIColor.brown.cgColor,
                UIColor.green.cgColor,
                UIColor.green.cgColor
            ]
        
        brownAndGreenLayer.locations = [0, 0.5, 0.5, 1.0]
        brownAndGreenLayer.startPoint = CGPoint(x:0, y:0)
        brownAndGreenLayer.endPoint = CGPoint(x: 1, y: 1)
        
        myBrownAndGreenButtonOutlet.layer.insertSublayer(brownAndGreenLayer, at: 0)
        
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
