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
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let allLoadedQuestions = decodeFromJSONFormat(readContentsOfFile("multiple_choice_questions", "json"))
        setQuestion(id: 0, questionsContainer: allLoadedQuestions)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setQuestion (id: Int, questionsContainer: [MultipleChoiceQuestion]) {
        
        quoteField.text = "\"\(questionsContainer[id].question)\""
        firstAnswerBtn.setTitle(questionsContainer[id].possibleAnswers[0], for:[])
        secondAnswerBtn.setTitle(questionsContainer[id].possibleAnswers[1], for:[])
        thirdAnswerBtn.setTitle(questionsContainer[id].possibleAnswers[2], for:[])
        
    }
    
    


}

