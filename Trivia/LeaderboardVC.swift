//
//  LeaderboardVC.swift
//  Trivia
//
//  Created by Brian van de Velde on 10-12-18.
//  Copyright © 2018 Brian van de Velde. All rights reserved.
//

import UIKit

class LeaderboardVC: UITableViewController
{
    // defines variables
    var scores: [[String:Any]]?
    
    // defines outlets
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    // sets initial view
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    // amount of rows is equel to amount of scores
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.scores!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    // puts the name and score of a player in the table view
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let item = self.scores![indexPath.row]
        cell.textLabel?.text = item["name"] as? String
        cell.detailTextLabel?.text = item["score"] as? String
        
    }
}
