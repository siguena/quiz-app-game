//
//  LoadDataFromFile.swift
//  QuoteQuizApp
//
//  Created by Vladimir Milushev on 18.11.17.
//  Copyright © 2017 Vladimir Milushev. All rights reserved.
//

import UIKit

func readContentsOfFile(_ fileName: String, _ fileType: String) -> NSData {
    
    let filePath = Bundle.main.path(forResource: fileName, ofType: fileType)
    let data = try? NSData(contentsOfFile: filePath!, options: NSData.ReadingOptions.dataReadingMapped )
    return data!

}

func decodeFromJSONFormat(_ data: NSData) -> [QuizDataModel] {
    
    let questionsDecodedFromJSON = try? JSONDecoder().decode([QuizDataModel].self, from: data as Data)
    return questionsDecodedFromJSON!
    
}


