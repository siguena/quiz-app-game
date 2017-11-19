//
//  GameSettingsVC.swift
//  QuoteQuizApp
//
//  Created by Vladimir Milushev on 18.11.17.
//  Copyright © 2017 Vladimir Milushev. All rights reserved.
//

import UIKit

class GameSettingsVC: UIViewController {

    @IBOutlet weak var switchModeSlider: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchModeSlider.addTarget(self, action: #selector(GameSettingsVC.sliderChangedState(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if (PlayerScoreAndDataForSession.globalScore.isDefaultGameMode){
            
        switchModeSlider.setOn(true, animated: false)
            
    }   else {
            
            switchModeSlider.setOn(false, animated: false)
    }
    
}

    @IBAction func gameSettingChanged(_ sender: UISwitch) {
        if(sender.isOn){
            PlayerScoreAndDataForSession.globalScore.isDefaultGameMode = true
        }
        else {
                PlayerScoreAndDataForSession.globalScore.isDefaultGameMode = false
        }
    
    }
    
    @objc func sliderChangedState(_ sender: UISwitch) {

        PlayerScoreAndDataForSession.globalScore.isGameModeChanged = true
    }

}

