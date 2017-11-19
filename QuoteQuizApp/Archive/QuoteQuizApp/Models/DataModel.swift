//
//  DataModel.swift
//  QuoteQuizApp
//
//  Created by Vladimir Milushev on 18.11.17.
//  Copyright © 2017 Vladimir Milushev. All rights reserved.
//

import UIKit

//Data Model for Question Data
struct QuizDataModel: Codable {
    let questionType: String
    let question: String
    let possibleAnswers: [String]
    let correctAnswer: String
}

//Global Variables
class PlayerScoreAndDataForSession {
    static let globalScore = PlayerScoreAndDataForSession()
    
    var isDefaultGameMode = true
    var isGameModeChanged = false
    var multipleAnswersData =  [QuizDataModel]()
    var yesNoAnswerData = [QuizDataModel]()
    var currentQuestionID = 0
    var currentScore = 0
}

//Custom Button Styling
class CustomButtonStyle: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}
