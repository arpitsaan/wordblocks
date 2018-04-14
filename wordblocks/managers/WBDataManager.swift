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
    var allWords = [String:String]()
    
    //shared manager
    static let sharedInstance = WBDataManager.init()
    
    override init() {
        super.init()
        allWords = loadWordsFromFile(name: "words")
    }
    
    
    func loadWordsFromFile(name: String) -> Dictionary<String,String> {
        do {
            
            // Fetch URL
            let url = Bundle.main.url(forResource: name, withExtension: "json")!
            
            // Load Data
            let data = try! Data(contentsOf: url)
            
            // Deserialize JSON
            let JSON = try! JSONSerialization.jsonObject(with: data, options: [])
            
            if let jsonArray = JSON as? Array<Any> {
                var testDict = [String : String]()
                for arrayObject in jsonArray {
                    if let pairDict = arrayObject as? Dictionary<String, String> {
                        testDict[pairDict["text_eng"]!] = pairDict["text_spa"]
                    }
                }
                return testDict
            }
        }
        return Dictionary()
    }
    
    func getAllWords() -> Dictionary<String, String> {
        if allWords.count == 0 {
            allWords = WBDataManager.sharedInstance.loadWordsFromFile(name: "words")
        }
        return allWords
    }
    
    func logLoadedWords()  {
        print(getAllWords())
    }
}
