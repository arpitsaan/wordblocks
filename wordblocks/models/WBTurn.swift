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
    var gameState:WBGameState
    //v2    var turnIndex:Int
    //v2    var correctAnsCount:Int
    //v2    var correctMatchedAnsCount:Int
    //v2    var currentStreak:Int
    
    init(score:Int = 0,
        activeLives:Int = 3,
        turnWord:WBTurnWord? = WBTurnWord.init(),
        gameState:WBGameState = .welcome
        ) {
        
        self.score = score
        self.activeLives = activeLives
        self.turnWord = turnWord!
        self.gameState = gameState
    }
}
