//  Jake Oliger     -  joliger@indiana.edu
//  Dilzat Muradil  -  dmuradil@indiana.edu
//
//  Pong for iOS
//  Submitted for C323 Mobile App Development on June 18th, 2021
//
//  HighscoresTableViewController.swift
//  C323-Pong-Team10
//
//  Created by Oliger, Jake on 6/10/21.
//

import UIKit

class HighscoresTableViewController: UITableViewController {

    var highscores: HighscoresModel?
    
    override func viewWillAppear(_ animated: Bool)
    {
        
        super.viewWillAppear(animated)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            self.highscores = appDelegate.highscores
            self.highscores?.load()
            tableView.reloadData()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.highscores?.highscores.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highscore", for: indexPath)

        let name: String = self.highscores!.highscores[indexPath.row].value(forKey: "name") as! String
        let time_ms: Int = self.highscores!.highscores[indexPath.row].value(forKey: "time_ms") as! Int
        let difficulty: Int16 = self.highscores!.highscores[indexPath.row].value(forKey: "difficulty") as! Int16
        let time_s: Double = Double(time_ms) / 1000

        let minutes = Int(floor(time_s / 60))
        let seconds = Int(floor(time_s - Double(minutes) * 60))
        let milliseconds = Int((time_s - Double(seconds)) * 1000)
        let timeLabel = String(format: "%01d:%02d.%01d", minutes, seconds, milliseconds)
        var difficultyStr = "unknown difficulty"
        
        switch difficulty {
            case Difficulty.easy.rawValue:
                difficultyStr = "Easy"
                break
            case Difficulty.normal.rawValue:
                difficultyStr = "Normal"
                break
            case Difficulty.hard.rawValue:
                difficultyStr = "Hard"
                break
            default:
                difficultyStr = "Error"
                break
        }
        
        cell.textLabel!.text = "\(indexPath.row + 1)) \(name)"
        cell.detailTextLabel!.text = "\(timeLabel) on \(difficultyStr)"
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
