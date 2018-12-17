//
//  QuestionVC.swift
//  Trivia
//
//  Created by Brian van de Velde on 10-12-18.
//  Copyright © 2018 Brian van de Velde. All rights reserved.
//

import UIKit
import HTMLString

class QuestionVC: UIViewController
{
    @IBOutlet weak var kim: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionNumber: UILabel!
    @IBOutlet weak var questionDifficulty: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreNumber: UILabel!
    @IBOutlet weak var questionDescription: UILabel!
    @IBOutlet weak var A: UIButton!
    @IBOutlet weak var B: UIButton!
    @IBOutlet weak var C: UIButton!
    @IBOutlet weak var D: UIButton!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var finalMessage: UILabel!
    @IBOutlet weak var nameBar: UITextField!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var progressIndex = 0
    var j = 0
    var answer = [String]()
    var question: [QuestionStruct]?
    var score = 0
    var questionNr = 0
    var name: String?
    let fetchquestion = fetch()
    var scores: [[String:Any]]?
    var stopped = 0
    
    @IBAction func submitPressed(_ sender: Any)
    {
        name = nameBar.text
        self.fetchquestion.submitResults(name: self.name, score: self.score)
        sleep(1)
        self.fetchquestion.fetchResult{ (test) in
            if let test = test
            {
                self.scores = test
                print(self.scores)
            }
        }
        while self.stopped == 0
        {
            if self.scores != nil
            {
                self.stopped = 1
                performSegue(withIdentifier: "leaderboardSegue", sender: submit)
                break;
            }
        }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        Options()
        
        if self.questionNr <= (question!.count - 1)
        {
            self.submit.isHidden = true
            self.finalMessage.isHidden = true
            self.nameBar.isHidden = true
            self.kim.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "leaderboardSegue" {
            let leaderboardNC = segue.destination as! UINavigationController
            let leaderboardVC = leaderboardNC.topViewController as! LeaderboardVC
            leaderboardVC.scores = self.scores
        }
    }

    @IBAction func answerPressed1(_ sender: Any)
    {
        if A.title(for: .normal) == question![j].correct_answer
        {
            ScoreWin()
            progressIndex += 1
        }
        else
        {
            ScoreLose()
            progressIndex += 1
        }
        
        Done()
    }
    
    @IBAction func answerPressed2(_ sender: Any)
    {
        if B.title(for: .normal) == question![j].correct_answer
        {
            ScoreWin()
            progressIndex += 1
        }
        else
        {
            ScoreLose()
            progressIndex += 1
        }
        
        Done()
    }
    
    @IBAction func answerPressed3(_ sender: Any)
    {
        if C.title(for: .normal) == question![j].correct_answer
        {
            ScoreWin()
            progressIndex += 1
        }
        else
        {
            ScoreLose()
            progressIndex += 1
        }
        
        Done()
    }
    
    @IBAction func answerPressed4(_ sender: Any)
    {
        if D.title(for: .normal) == question![j].correct_answer
        {
            ScoreWin()
            progressIndex += 1
        }
        else
        {
            ScoreLose()
            progressIndex += 1
        }
        
        Done()
    }
    
    func end()
    {
        scoreNumber.text = "\(score)"
        finalMessage.text = "Your final score is \(score)! Please enter your name"
        
        self.kim.isHidden = false
        self.nameBar.isHidden = false
        self.submit.isHidden = false
        self.finalMessage.isHidden = false
        self.questionDifficulty.isHidden = true
        self.difficultyLabel.isHidden = true
        self.questionDescription.isHidden = true
        self.progressBar.isHidden = true
        self.A.isHidden = true
        self.B.isHidden = true
        self.C.isHidden = true
        self.D.isHidden = true
    }
    
    func ScoreLose()
    {
        showAlertLose()
        
        switch question![j].difficulty.removingHTMLEntities
        {
        case "easy":
            if score >= 5
            {
                score -= 5
            }
            else
            {
                score -= score
            }
        case "medium":
            if score >= 3
            {
                score -= 3
            }
            else
            {
                score -= score
            }
        case "hard":
            if score >= 1
            {
                score -= 1
            }
        default:
            print("wow")
        }
    }
    
    func ScoreWin()
    {
        switch question![j].difficulty.removingHTMLEntities
        {
        case "easy":
            score += 1
        case "medium":
            score += 5
        case "hard":
            score += 10
        default:
            print("wow")
        }
        
        showAlertWin()
    }
    
    func Done()
    {
        answer.removeAll()
        j += 1
        
        if j > (question!.count - 1)
        {
            end()
        }
        else
        {
            Options()
        }
    }
    
    func Options()
    {
        scoreNumber.text = "\(score)"
        
        questionNr = j + 1
        questionNumber.text = "\(questionNr)"
        
        let totalProgress = Float(progressIndex) / Float(question!.count)
        progressBar.setProgress(totalProgress, animated: true)
        
        answer.append(question![j].correct_answer.removingHTMLEntities)
        
        for i in question![j].incorrect_answers
        {
            answer.append(i.removingHTMLEntities)
        }
        
        answer.shuffle()
        self.questionDescription.text = question![j].question.removingHTMLEntities
        self.questionDifficulty.text = question![j].difficulty.removingHTMLEntities
        self.A.setTitle(answer[0], for: .normal)
        self.B.setTitle(answer[1], for: .normal)
        self.C.setTitle(answer[2], for: .normal)
        self.D.setTitle(answer[3], for: .normal)
    }
    
    func showAlertWin()
    {
        let alert = UIAlertController(title: "YEAH", message: "Correct!!", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 1
        subview.backgroundColor = UIColor(red: (0/255.0), green: (255/255.0), blue: (0/255.0), alpha: 1.0)
        
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    func showAlertLose()
    {
        let alert = UIAlertController(title: "BOOH", message: "Incorrect!!", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let subview = (alert.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 1
        subview.backgroundColor = UIColor(red: (255/255.0), green: (0/255.0), blue: (0/255.0), alpha: 1.0)
        
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }

}
