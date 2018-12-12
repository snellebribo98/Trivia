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
    
    var j = 0
    var answer = [String]()
    var question: [QuestionStruct]?
    var score = 0
    var questionNr = 0
    var name: String?
    let fetchquestion = fetch()
    var results: [[String:Any]]?
    
    @IBAction func submitPressed(_ sender: Any)
    {
        print(score)
        name = nameBar.text
        DispatchQueue.main.async()
        {
            self.fetchquestion.submitResults(name: self.name, score: self.score)
//            self.fetchquestion.fetchResult{ (test) in
//                if let test = test
//                {
//                    self.results = test
//                }
//            }
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

    @IBAction func answerPressed1(_ sender: Any)
    {
        if A.title(for: .normal) == question![j].correct_answer
        {
            ScoreWin()
        }
        else
        {
            ScoreLose()
        }
        
        Done()
    }
    
    @IBAction func answerPressed2(_ sender: Any)
    {
        if B.title(for: .normal) == question![j].correct_answer
        {
            ScoreWin()
        }
        else
        {
            ScoreLose()
        }
        
        Done()
    }
    
    @IBAction func answerPressed3(_ sender: Any)
    {
        if C.title(for: .normal) == question![j].correct_answer
        {
            ScoreWin()
        }
        else
        {
            ScoreLose()
        }
        
        Done()
    }
    
    @IBAction func answerPressed4(_ sender: Any)
    {
        if D.title(for: .normal) == question![j].correct_answer
        {
            ScoreWin()
        }
        else
        {
            ScoreLose()
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
        self.questionDescription.isHidden = true
        self.A.isHidden = true
        self.B.isHidden = true
        self.C.isHidden = true
        self.D.isHidden = true
    }
    
    func ScoreLose()
    {
        showAlertLose()
        
        if score >= 1
        {
            score -= 1
        }
        else
        {
            score == score
        }
    }
    
    func ScoreWin()
    {
        score += 5
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
        
        answer.append(question![j].correct_answer.removingHTMLEntities)
        
        for i in question![j].incorrect_answers
        {
            answer.append(i.removingHTMLEntities)
        }
        
        answer.shuffle()
        self.questionDescription.text = question![j].question.removingHTMLEntities
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
