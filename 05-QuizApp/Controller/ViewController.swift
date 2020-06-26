//
//  ViewController.swift
//  05-QuizApp
//
//  Created by Daniel Hidalgo on 22/01/2020.
//  Copyright © 2020 HSN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // UI Elements
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelQuestionsNumber: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var progressBar: UIView!
    
    // Data elements
    let questionFactory: QuestionFactory = QuestionFactory()
    var currentQuestion: Question!
    var currentQuestionID: Int!
    var currentScore: Int!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startGame()
    }
    
    func updateUIElements(){
        // update UI elements
       labelQuestion.text = "\(currentQuestion.question)"
       labelQuestionsNumber.text = "\(currentQuestionID + 1)/\(questionFactory.questionsBank.questions.count)"
       labelScore.text = "\(NSLocalizedString("score.text", comment: "Score")) \(String(currentScore))"
       
       // update progress bar
       for constraint in progressBar.constraints {
           if constraint.identifier == "width" {
               constraint.constant = (CGFloat(self.view.frame.size.width) / CGFloat(questionFactory.questionsBank.questions.count)) * CGFloat(currentQuestionID)
           }
       }
    }
    
    func startGame() {
        
        // shuffle questions
        questionFactory.questionsBank.questions.shuffle()
        
        // initialize data
        currentScore = 0
        currentQuestion = questionFactory.getQuestion(index: 0)
        currentQuestionID = 0
        
        // update ui elements
        updateUIElements()
        
    }
    
    func gameOver() {
        let success1 = NSLocalizedString("game.over.message1", comment: "Success message 1")
        let success2 = NSLocalizedString("game.over.message2", comment: "Success message 2")
        let scoresString = "\(success1) \(String(currentScore)) \(success2) \(String(questionFactory.questionsBank.questions.count))"
        
        let gameOverMessage = NSLocalizedString("game.over.text", comment: "Game over")
        let alert: UIAlertController = UIAlertController(title: gameOverMessage, message: scoresString, preferredStyle: .alert)
        let actionAlert: UIAlertAction = UIAlertAction(title: NSLocalizedString("accept.text", comment: "Accept"), style: .default) { (_) in
            self.startGame()
        }
        alert.addAction(actionAlert)
        present(alert, animated: true, completion: nil)
    }
    
    func nextQuestion() {
        // if is the last question
        if (currentQuestionID + 1) == questionFactory.questionsBank.questions.count {
            gameOver()
        }else {
            currentQuestionID += 1
            currentQuestion = questionFactory.getQuestion(index: currentQuestionID)
           
            // update ui elements
            updateUIElements()
        }
        
    }
    
    func resolveQuestion(buttonTag: Int) {
        var isCorrect: Bool = true
        if buttonTag == 1 {
            // push true
            isCorrect = (currentQuestion.answer == true)
            
        }else if buttonTag == 0 {
            // push false
            isCorrect = (currentQuestion.answer == false)
        }
        
        let alert = UIAlertController(title: "Text", message: "Answer", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Aceptar", comment: "Default action"), style: .default, handler: { _ in
            self.nextQuestion()
        }))
        
        if isCorrect {
            
            // Show alert
            alert.title = NSLocalizedString("success.text", comment: "Success")
            alert.message = NSLocalizedString("answer.placeholder", comment: "Answer Placeholder")
            
            currentScore += 1
            present(alert, animated: true, completion: nil)
        }else {
            // show alert
            alert.title = NSLocalizedString("incorrect.text", comment: "Incorrect")
            alert.message = NSLocalizedString("answer.placeholder", comment: "Answer Placeholder")
            present(alert, animated: true, completion: nil)
        }
        
    }


    @IBAction func answerButton(_ sender: UIButton) {
        resolveQuestion(buttonTag: sender.tag)
    }
}

