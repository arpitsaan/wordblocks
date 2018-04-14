//
//  WBTurn.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 15/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

struct WBTurnWord {
    var topWord:WBWord
    var bottomWord:WBWord
    var isMatching:Bool = false
}

struct WBTurn {
    var score:Int = 0
    var activeLives:Int = 3
    var turnWord:WBTurnWord
    var turnIndex:Int = 0
    var correctAnsCount:Int = 0
    var correctMatchedAnsCount:Int = 0
    var currentStreak:Int = 0
    var gameState:WBGameState
}
