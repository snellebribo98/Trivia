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
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }
}
