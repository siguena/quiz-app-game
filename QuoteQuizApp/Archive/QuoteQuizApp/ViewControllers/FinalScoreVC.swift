//
//  FinalScoreVC.swift
//  QuoteQuizApp
//
//  Created by Vladimir Milushev on 18.11.17.
//  Copyright © 2017 Vladimir Milushev. All rights reserved.
//

import UIKit

class FinalScoreVC: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "\(PlayerScoreAndDataForSession.globalScore.currentScore) / 10 Correct Answers"
        //Reset score uppon game completion
        PlayerScoreAndDataForSession.globalScore.currentScore = 0
    
    }
    
}
