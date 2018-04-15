//
//  WBGameManager.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 15/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

enum WBUserAction {
    case tapStart
    case tapPause
    case tapResume
    case tapRestart
    case tapTick
    case tapCross
    case tapScreen
    case exitGame
}

enum WBGameState {
    case welcome
    case start
    case active
    case pause
    case won
    case lost
    case gameover
}

extension Notification.Name {
    static let gameManager  = Notification.Name("WBGameManagerChannel")
}

class WBGameManager: NSObject {
    public static var highScore:Int = 0
    public static var currentTurn:WBTurn = WBTurn()
    
    private static var remainingWords = [WBWord]()
    
    //begin game
    public static func beginGame() {
        //get all words
        remainingWords = WBDataManager.getAllWords()
        print(remainingWords)
        
        //high score
        highScore = UserDefaults.standard.integer(forKey:"wbhighscore")
        print("[WB] HighScoreLoaded as : \(highScore)")
        
        
        //current turn
        currentTurn = WBTurn.init(score: 0, activeLives: 3, turnWord:getRandomTurnWord(), gameState: .welcome)
        
        //notification broadcast
        let updateNotification = Notification.init(name: .gameManager)
        NotificationCenter.default.post(updateNotification)
    }
    
    private static func getRandomTurnWord() -> WBTurnWord {
        var randomBottomWord = remainingWords.random()
        let randomTopWord = remainingWords.random()
        
        //same word bias
        let spreadCount:Int = Int(1/WBGameConfig.matchingBias.value) //lower spread is higher matching
        let randomNum:UInt32 = arc4random_uniform(UInt32(spreadCount))
        var shouldMatch:Bool = false
        if randomNum==1 {
            print("[WB] Same word! \(randomBottomWord.en), \(randomBottomWord.es)")
            randomBottomWord = randomTopWord
            shouldMatch = true
        }
        
        return WBTurnWord.init(topWord: randomTopWord, bottomWord: randomBottomWord, isMatching: shouldMatch)
    }
    
    //next turn - like redux reducers
    public static func updateTurn(action:WBUserAction) {
        
        var nextTurn = currentTurn
        
        switch action {
            case .tapStart: nextTurn.gameState = .start
            
            case .tapPause: nextTurn.gameState = .pause
            
            case .tapResume: nextTurn.gameState = .pause
            
            case .tapRestart:
                nextTurn.gameState = .welcome
            
            case .tapTick: break
            
            case .tapCross: break
            
            case .tapScreen: break
            
            case .exitGame: break
        }
        
        currentTurn = nextTurn
        
        //notification broadcast
        let updateNotification = Notification.init(name: .gameManager)
        NotificationCenter.default.post(updateNotification)
    }
}
