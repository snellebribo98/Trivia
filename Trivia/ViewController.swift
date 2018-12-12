//
//  ViewController.swift
//  Trivia
//
//  Created by Brian van de Velde on 10-12-18.
//  Copyright © 2018 Brian van de Velde. All rights reserved.
//

import UIKit
import HTMLString

class ViewController: UIViewController
{

    @IBOutlet weak var startGame: UIButton!
    @IBOutlet weak var leaderboard: UIButton!
    
    var a: [QuestionStruct]?
    var fetchdata = fetch()
    var scores: [[String:Any]]?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        fetchdata.fetchQuestion
        { (q1) in if let q2 = q1
            {
                self.a = q2
                print(self.a)
            }
        }
        self.fetchdata.fetchResult{ (test) in
            if let test = test
            {
                self.scores = test
                print(self.scores)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "questionSegue"
        {
            let questionVC = segue.destination as! QuestionVC
            questionVC.question = self.a
        }
        else if segue.identifier == "leaderboardSegue2"
        {
            let leaderboardNC = segue.destination as! UINavigationController
            let leaderboardVC = leaderboardNC.topViewController as! LeaderboardVC
            leaderboardVC.scores = self.scores
        }
    }

}

