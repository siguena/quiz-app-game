//
//  DataModel.swift
//  QuoteQuizApp
//
//  Created by Vladimir Milushev on 18.11.17.
//  Copyright © 2017 Vladimir Milushev. All rights reserved.
//

import UIKit

struct MultipleChoiceQuestion: Codable {
    let questionType: String
    let question: String
    let possibleAnswers: [String]
    let correctAnswer: String
}


class PlayerScoreAndDataForSession {
    static let globalScore = PlayerScoreAndDataForSession()
    
    var questionData =  [MultipleChoiceQuestion]()
    var currentQuestionID = 0
    var currentScore = 0
}

class CustomButtonStyle: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}
