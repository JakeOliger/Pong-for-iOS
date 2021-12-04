//  Jake Oliger     -  joliger@indiana.edu
//  Dilzat Muradil  -  dmuradil@indiana.edu
//
//  Pong for iOS
//  Submitted for C323 Mobile App Development on June 18th, 2021
//
//  SettingsModel.swift
//  C323-Pong-Team10
//
//  Created by Oliger, Jake on 6/15/21.
//

import Foundation
import SpriteKit
import CoreData

enum Difficulty: Int16 {
    case easy, normal, hard
}

class SettingsModel {
    var settings: [NSManagedObject]
    var name: String
    var difficulty: Difficulty
    var bgColor: UIColor // background color
    var fgColor: UIColor // foreground color
    
    var names = [String]()
    
    init() {
        self.settings = []
        self.name = "unnamed player"
        self.difficulty = Difficulty.normal
        self.bgColor = UIColor.black
        self.fgColor = UIColor.white
    }
    
    func load() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentSettings.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Settings")
        
        do {
            self.settings = try managedContext.fetch(fetchRequest)
            if self.settings.count > 0 {
                self.difficulty = Difficulty.init(rawValue: self.settings[0].value(forKey: "difficulty") as! Int16) ?? Difficulty.normal
                self.name = self.settings[0].value(forKey: "name") as! String
                let fgColor_r = self.settings[0].value(forKey: "fgColor_r") as! Float
                let fgColor_g = self.settings[0].value(forKey: "fgColor_g") as! Float
                let fgColor_b = self.settings[0].value(forKey: "fgColor_b") as! Float
                let bgColor_r = self.settings[0].value(forKey: "bgColor_r") as! Float
                let bgColor_g = self.settings[0].value(forKey: "bgColor_g") as! Float
                let bgColor_b = self.settings[0].value(forKey: "bgColor_b") as! Float
                
                self.fgColor = UIColor.init(red: CGFloat(fgColor_r), green: CGFloat(fgColor_g), blue: CGFloat(fgColor_b), alpha: CGFloat(1.0))
                self.bgColor = UIColor.init(red: CGFloat(bgColor_r), green: CGFloat(bgColor_g), blue: CGFloat(bgColor_b), alpha: CGFloat(1.0))
            }
        } catch let error as NSError {
            print("Couldn't load: \(error), \(error.code)")
        }
    }
    
    func save() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentSettings.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Settings",
                                                in: managedContext)!
        let setting = NSManagedObject(entity: entity, insertInto: managedContext)
        
        var fgColor_r: CGFloat = 0.0
        var fgColor_g: CGFloat = 0.0
        var fgColor_b: CGFloat = 0.0
        var bgColor_r: CGFloat = 0.0
        var bgColor_g: CGFloat = 0.0
        var bgColor_b: CGFloat = 0.0
        var useless: CGFloat = 0.0
        
        self.fgColor.getRed(&fgColor_r, green: &fgColor_g, blue: &fgColor_b, alpha: &useless)
        self.bgColor.getRed(&bgColor_r, green: &bgColor_g, blue: &bgColor_b, alpha: &useless)
        
        setting.setValue(self.name, forKeyPath: "name")
        setting.setValue(self.difficulty.rawValue, forKeyPath: "difficulty")
        setting.setValue(Float(fgColor_r), forKeyPath: "fgColor_r")
        setting.setValue(Float(fgColor_g), forKeyPath: "fgColor_g")
        setting.setValue(Float(fgColor_b), forKeyPath: "fgColor_b")
        setting.setValue(Float(bgColor_r), forKeyPath: "bgColor_r")
        setting.setValue(Float(bgColor_g), forKeyPath: "bgColor_g")
        setting.setValue(Float(bgColor_b), forKeyPath: "bgColor_b")
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "Settings"))
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
            self.settings = [setting]
        } catch let error as NSError {
            print("Couldn't save: \(error), \(error.userInfo)")
        }
    }
    func setName(_ name: String) {
        self.name = name
        self.save()
    }
    
    func setDifficulty(_ difficulty: Difficulty) {
        self.difficulty = difficulty
        self.save()
    }
    
    func setForeground(_ foreground: UIColor) {
        self.fgColor = foreground
        self.save()
    }
    
    func setBackground(_ background: UIColor) {
        self.bgColor = background
        self.save()
    }
}
