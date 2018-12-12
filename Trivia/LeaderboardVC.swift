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
    var scores: [[String:Any]]?
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.scores!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    //
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let item = self.scores![indexPath.row]
        cell.textLabel?.text = item["name"] as? String
        cell.detailTextLabel?.text = item["score"] as? String
        
    }
}
