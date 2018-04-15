//
//  WBDataManager.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 14/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class WBDataManager: NSObject {
    //properties
    public static var allWords = [WBWord]()
    
    public static func getAllWords() -> [WBWord] {
        if allWords.count == 0 {
            allWords = WBDataManager.loadWordsFromFile(name: "words")
        }
        return allWords
    }
    
    private static func logLoadedWords()  {
        print(getAllWords())
    }
    
    
    private static func loadWordsFromFile(name: String) -> [WBWord] {
        //empty array
        var wordsToReturn = [WBWord]()
        
        do {
            
           
            
            // Fetch URL
            let url = Bundle.main.url(forResource: name, withExtension: "json")!
            
            // Load Data
            let data = try! Data(contentsOf: url)
            
            // Deserialize JSON
            let JSON = try! JSONSerialization.jsonObject(with: data, options: [])
            
            if let jsonArray = JSON as? Array<Any> {
                for arrayObject in jsonArray {
                    if let pairDict = arrayObject as? Dictionary<String, String> {
                        let engWord = pairDict["text_eng"]
                        let spaWord = pairDict["text_spa"]
                        
                        let wordPair:WBWord = WBWord.init(en: engWord!, es: spaWord!, isDone: false)
                        wordsToReturn.append(wordPair)
                    }
                }
            }
        }
        
        return wordsToReturn
    }
    
}
