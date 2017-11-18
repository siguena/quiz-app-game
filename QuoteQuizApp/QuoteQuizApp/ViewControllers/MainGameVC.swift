//
//  MainGameVC.swift
//  QuoteQuizApp
//
//  Created by Vladimir Milushev on 18.11.17.
//  Copyright © 2017 Vladimir Milushev. All rights reserved.
//

import UIKit

class MainGameVC: UIViewController {

    @IBOutlet weak var quoteField: UITextView!
    
    @IBOutlet weak var firstAnswerBtn: UIButton!
    @IBOutlet weak var secondAnswerBtn: UIButton!
    @IBOutlet weak var thirdAnswerBtn: UIButton!
    
    @IBAction func answerBtnWasPressed(sender: UIButton) {
        
        checkAnswerAndUpdateScore(playerAnswer: (sender.titleLabel?.text)!)
    }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial load of questions from file
        PlayerScoreAndDataForSession.globalScore.questionData = decodeFromJSONFormat(readContentsOfFile("multiple_choice_questions", "json"))
        
        setQuestion(id: 0, questionsContainer: PlayerScoreAndDataForSession.globalScore.questionData)
        
    }

    
    //Set question to labels and text filed
    func setQuestion (id: Int, questionsContainer: [MultipleChoiceQuestion]) {
        
        quoteField.text = "\"\(questionsContainer[id].question)\""
        firstAnswerBtn.setTitle(questionsContainer[id].possibleAnswers[0], for:[])
        secondAnswerBtn.setTitle(questionsContainer[id].possibleAnswers[1], for:[])
        thirdAnswerBtn.setTitle(questionsContainer[id].possibleAnswers[2], for:[])
   
    }
    
    func createModalPopup (userAnswerText: String) {
        let modalPopup = UIAlertController(title: "", message: userAnswerText, preferredStyle: .alert)
        modalPopup.addAction(UIAlertAction(title: "OK", style: .default,handler: loadNextQuestion))
        
        self.present(modalPopup, animated: true, completion:nil)

        }
    
    func checkAnswerAndUpdateScore(playerAnswer: String) {
        
        let questions = PlayerScoreAndDataForSession.globalScore.questionData
        let questionId = PlayerScoreAndDataForSession.globalScore.currentQuestionID
        
        if questions[questionId].correctAnswer == playerAnswer{
            
            let correctAnswer = "Correct! The right answer is: \(questions[questionId].correctAnswer)"
            createModalPopup(userAnswerText:  correctAnswer)
            PlayerScoreAndDataForSession.globalScore.currentScore += 1
            
        } else {
            
            let wrongAnswer = "Sorry, you are wrong! The right answer is: \(questions[questionId].correctAnswer)"
            createModalPopup(userAnswerText:  wrongAnswer)
            
        }
        
    }
    
    
    func loadNextQuestion(_ action: UIAlertAction) {
    
        PlayerScoreAndDataForSession.globalScore.currentQuestionID += 1
        
        if PlayerScoreAndDataForSession.globalScore.currentQuestionID < 10 {
        
            setQuestion(id: PlayerScoreAndDataForSession.globalScore.currentQuestionID, questionsContainer: PlayerScoreAndDataForSession.globalScore.questionData)
        

        } else {
            
            PlayerScoreAndDataForSession.globalScore.currentQuestionID = 0
            setQuestion(id: PlayerScoreAndDataForSession.globalScore.currentQuestionID, questionsContainer: PlayerScoreAndDataForSession.globalScore.questionData)
            
            performSegue(withIdentifier: "FinalScoreSegue", sender: self)
        }

    }
    
}

