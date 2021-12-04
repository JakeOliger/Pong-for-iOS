//  Jake Oliger     -  joliger@indiana.edu
//  Dilzat Muradil  -  dmuradil@indiana.edu
//
//  Pong for iOS
//  Submitted for C323 Mobile App Development on June 18th, 2021
//
//  HighscoresModel.swift
//  C323-Pong-Team10
//
//  Created by Oliger, Jake on 6/15/21.
//

import Foundation
import CoreData
import UIKit // To access AppDelegate

struct Score {
    let name: String
    let time_ms: Int
    var difficulty: Difficulty
}

class HighscoresModel {
    var highscores: [NSManagedObject]
    
    init() {
        self.highscores = []
        // Load highscores when we have the persistent container
    }
    
    func load() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentHighscores.viewContext
        let sort = NSSortDescriptor(key: "time_ms", ascending: true)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Highscore")
        fetchRequest.sortDescriptors = [sort]
        
        do {
            self.highscores = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Couldn't load: \(error), \(error.code)")
        }
    }
    
    func save(name: String, time_ms: Int, difficulty: Difficulty) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentHighscores.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Highscore",
                                                in: managedContext)!
        let highscore = NSManagedObject(entity: entity, insertInto: managedContext)
        highscore.setValue(name, forKeyPath: "name")
        highscore.setValue(difficulty.rawValue, forKeyPath: "difficulty")
        highscore.setValue(time_ms, forKeyPath: "time_ms")
        do {
            try managedContext.save()
            self.highscores.append(highscore)
        } catch let error as NSError {
            print("Couldn't save: \(error), \(error.userInfo)")
        }
    }
}
