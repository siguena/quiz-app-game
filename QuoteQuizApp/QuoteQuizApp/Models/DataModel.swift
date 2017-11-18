//
//  DataModel.swift
//  QuoteQuizApp
//
//  Created by Vladimir Milushev on 18.11.17.
//  Copyright © 2017 Vladimir Milushev. All rights reserved.
//

import Foundation

struct MultipleChoiceQuestion: Codable {
    let questionType: String
    let question: String
    let possibleAnswers: [String]
    let correctAnswer: String
}
