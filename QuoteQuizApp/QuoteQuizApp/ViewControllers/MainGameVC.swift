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
    
    @IBOutlet weak var multipleQuestionsSection: UIStackView!
    @IBOutlet weak var yesNoQuestionsSection: UIStackView!
    
    @IBOutlet weak var yesNoGameAuthorLabel: UILabel!
    
    @IBAction func answerBtnWasPressed(sender: UIButton) {
        
        checkAnswerAndUpdateScore(playerAnswer: (sender.titleLabel?.text)!)
    }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initial load of questions from files
        PlayerScoreAndDataForSession.globalScore.multipleAnswersData = decodeFromJSONFormat(readContentsOfFile("multiple_choice_questions", "json"))
        PlayerScoreAndDataForSession.globalScore.yesNoAnswerData =
            decodeFromJSONFormat(readContentsOfFile("yes_no_questions", "json"))
        
        //Default mode is "multiple Questions"
        setQuestion(id: 0, questionsContainer: PlayerScoreAndDataForSession.globalScore.multipleAnswersData)
        //Hide Yes/No game mode visual elements
        yesNoQuestionsSection.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Check for game type changed and update UI
        if (PlayerScoreAndDataForSession.globalScore.isGameModeChanged && PlayerScoreAndDataForSession.globalScore.isDefaultGameMode) {
            
            multipleQuestionsSection.isHidden = false
            yesNoQuestionsSection.isHidden = true
            PlayerScoreAndDataForSession.globalScore.isDefaultGameMode = true
            setQuestion(id: 0, questionsContainer: PlayerScoreAndDataForSession.globalScore.multipleAnswersData)
            PlayerScoreAndDataForSession.globalScore.currentScore = 0
            PlayerScoreAndDataForSession.globalScore.currentQuestionID = 0
            
            PlayerScoreAndDataForSession.globalScore.isGameModeChanged = false
            
        } else if (PlayerScoreAndDataForSession.globalScore.isGameModeChanged && !PlayerScoreAndDataForSession.globalScore.isDefaultGameMode){
            
            multipleQuestionsSection.isHidden = true
            yesNoQuestionsSection.isHidden = false
            
            PlayerScoreAndDataForSession.globalScore.isDefaultGameMode = false
            setQuestion(id: 0, questionsContainer: PlayerScoreAndDataForSession.globalScore.yesNoAnswerData)
            PlayerScoreAndDataForSession.globalScore.currentScore = 0
            PlayerScoreAndDataForSession.globalScore.currentQuestionID = 0
            
            PlayerScoreAndDataForSession.globalScore.isGameModeChanged = false
        }
    }

    
    //Set question to labels and text filed
    func setQuestion (id: Int, questionsContainer: [QuizDataModel]) {
        
        quoteField.text = "\"\(questionsContainer[id].question)\""
        
        if(PlayerScoreAndDataForSession.globalScore.isDefaultGameMode) {
        
        firstAnswerBtn.setTitle(questionsContainer[id].possibleAnswers[0], for:[])
        secondAnswerBtn.setTitle(questionsContainer[id].possibleAnswers[1], for:[])
        thirdAnswerBtn.setTitle(questionsContainer[id].possibleAnswers[2], for:[])
            
        } else {
            
            print(questionsContainer[id].possibleAnswers[0])
            yesNoGameAuthorLabel.text = questionsContainer[id].possibleAnswers[0]
            
        }
   
    }
    
    func createModalPopup (userAnswerText: String) {
        let modalPopup = UIAlertController(title: userAnswerText, message: "", preferredStyle: .alert)
        modalPopup.addAction(UIAlertAction(title: "OK", style: .default,handler: loadNextQuestion))
        
        self.present(modalPopup, animated: true, completion:nil)

        }
    
    func checkAnswerAndUpdateScore(playerAnswer: String) {
        
        var questions =  [QuizDataModel]()
        let questionId = PlayerScoreAndDataForSession.globalScore.currentQuestionID
        
        if(PlayerScoreAndDataForSession.globalScore.isDefaultGameMode){
            
            questions = PlayerScoreAndDataForSession.globalScore.multipleAnswersData
            
        } else {
            
            questions = PlayerScoreAndDataForSession.globalScore.yesNoAnswerData
            
        }
        
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
        
        var data = [QuizDataModel]()
        
        if(PlayerScoreAndDataForSession.globalScore.isDefaultGameMode) {
            data = PlayerScoreAndDataForSession.globalScore.multipleAnswersData
        } else {
            data = PlayerScoreAndDataForSession.globalScore.yesNoAnswerData
        }
        
        if PlayerScoreAndDataForSession.globalScore.currentQuestionID < 10 {
        
            setQuestion(id: PlayerScoreAndDataForSession.globalScore.currentQuestionID, questionsContainer: data)
        

        } else {
            
            PlayerScoreAndDataForSession.globalScore.currentQuestionID = 0
            setQuestion(id: PlayerScoreAndDataForSession.globalScore.currentQuestionID, questionsContainer: data)
            
            performSegue(withIdentifier: "FinalScoreSegue", sender: self)
        }

    }
    
}

