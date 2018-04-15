//
//  WBTurn.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 15/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

struct WBTurnWord {
    var topWordText:String
    var bottomWordText:String
    
    var topWord:WBWord
    var bottomWord:WBWord
    
    var isMatching:Bool
    
    init(topWord:WBWord = WBWord.init(),
         bottomWord:WBWord = WBWord.init(),
         isMatching:Bool = false) {
        self.topWord = topWord
        self.bottomWord = bottomWord
        self.isMatching = isMatching
        
        self.topWordText = topWord.en
        self.bottomWordText = bottomWord.es
    }
}

struct WBTurn {
    var score:Int
    var activeLives:Int
    var turnWord:WBTurnWord
//    var turnIndex:Int
//    var correctAnsCount:Int
//    var correctMatchedAnsCount:Int
//    var currentStreak:Int
    var gameState:WBGameState
    
    init(score:Int = 0,
        activeLives:Int = 3,
        turnWord:WBTurnWord? = WBTurnWord.init(),
//        turnIndex:Int = 0,
//        correctAnsCount:Int = 0,
//        correctMatchedAnsCount:Int = 0,
//        currentStreak:Int = 0,
        gameState:WBGameState = .welcome
        ) {
        
        self.score = score
        self.activeLives = activeLives
        self.turnWord = turnWord!
//        self.turnIndex = turnIndex
//        self.correctAnsCount = correctAnsCount
//        self.correctMatchedAnsCount = correctMatchedAnsCount
//        self.currentStreak = currentStreak
        self.gameState = gameState
    }
}
