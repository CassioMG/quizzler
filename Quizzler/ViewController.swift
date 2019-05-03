//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    
    var pickedAnswer = false
    var questionNumber = 0
    var score = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startOver()
    }

    
    @IBAction func answerPressed(_ sender: AnyObject) {
  
        if sender.tag == 1 {
            pickedAnswer = true
        } else {
            pickedAnswer = false
        }
        
        checkAnswer()
        updateUI()
        questionNumber += 1
        nextQuestion()
    }
    
    
    func updateUI() {
      
        let questionsCount = allQuestions.list.count
        
        progressLabel.text = "\(questionNumber + 1) / \(questionsCount)"
        scoreLabel.text = "Score: \(score)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(questionsCount)) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
    
        if questionNumber < allQuestions.list.count {
            
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
            
        } else {
            
            let alertController = UIAlertController(title: "Awesome!", message: "You've finished all the questions and scored \(score) points. Do you wanna start over?", preferredStyle: .alert)
            
            let alertRestartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            let alertQuitAction = UIAlertAction(title: "Quit the app", style: .destructive) { (UIAlertAction) in
                exit(0)
            }
            
            alertController.addAction(alertRestartAction)
            alertController.addAction(alertQuitAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    

    func checkAnswer() {
        
        if pickedAnswer == allQuestions.list[questionNumber].answer {
            score += 1
            ProgressHUD.showSuccess("Correct")
        
        } else {
            ProgressHUD.showError("Wrong!")
            
        }
    }
    
    
    func startOver() {
        
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    
    
}
