//
//  CurrentGameManager.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 14/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class CurrentGameManager: NSObject {
    //shared manager
    static let sharedInstance = CurrentGameManager()
    
    override init() {
        super.init()
    }
    
    //state properties
    private var currentScore:Int = 0
    private var highScore:Int = 0
    private var remainingLives:Int = 3
    private var wordCount:Int = 3
    private var isGameInProgress:Bool = true
    private var currentPair = NSDictionary()
    private var correctPair = NSDictionary()
    private var incorrectPair = NSDictionary()
    private var turnCount:Int = 0
}

//Init
extension CurrentGameManager {
    
}
    
//Getters, Setters
extension CurrentGameManager {
    //getters
    func getCurrentScore() -> Int {
        return currentScore
    }
    
    func getHighScore() -> Int {
        return highScore
    }
    
    func getRemainingLives() -> Int {
        return remainingLives
    }
    
    //setters
    func updateCurrentScore(score:Int) {
        currentScore = score
    }
    
    func updateHighScore() -> Int {
        return highScore
    }
    
    func reduceAndGetUpdatedLives() -> Int {
        remainingLives = remainingLives-1
        return remainingLives
    }
    
    func getCurrentPair() -> NSDictionary {
        return currentPair
    }
    
    func increaseTurnCount() {
        turnCount = turnCount + 1
    }
    
    func setRemainingLives(count: Int) {
        remainingLives = count
    }
}
