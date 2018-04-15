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
    case tapResume
    case tapRestart
    case tapTick
    case tapCross
    case tapScreen
    case collision
}

enum WBGameState {
    case welcome
    case start
    case active
    case won
    case lost
    case gameover
}

extension Notification.Name {
    static let gameManager  = Notification.Name("WBGameManagerChannel")
}

class Manager: NSObject {
    public static var highScore:Int = 0
    public static var previousTurn:WBTurn? = nil
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
        
        //first user turn
        currentTurn = WBTurn.init(score: 0, activeLives: 3, turnWord:getRandomTurnWord(), gameState: .welcome)
        
        //notification broadcast
        let updateNotification = Notification.init(name: .gameManager)
        NotificationCenter.default.post(updateNotification)
    }
    
    private static func getRandomTurnWord() -> WBTurnWord {
        var randomBottomWord = remainingWords.random()
        
        while randomBottomWord.isDone == true {
            randomBottomWord = remainingWords.random()
        }
        
        let randomTopWord = remainingWords.random()
        
        //same word bias - make a dice with multiple faces
        let randomLimit:Int = Int(1/WBGameConfig.matchingBias.value) //lower spread is higher matching
        let randomNum:UInt32 = arc4random_uniform(UInt32(randomLimit))
        var shouldMatch:Bool = false
        
        //when 1 rolls, its gonna be a matched face
        if randomNum==1 {
            print("[WB] Same word! \(randomBottomWord.en), \(randomBottomWord.es)")
            randomBottomWord = randomTopWord
            shouldMatch = true
        }
        
        return WBTurnWord.init(topWord: randomTopWord, bottomWord: randomBottomWord, isMatching: shouldMatch)
    }
    
    //Next Turn State Machine
    public static func updateTurn(action:WBUserAction) {
        
        var nextTurn = currentTurn
        var shouldChangeWord = false
        
        switch action {
        case .tapStart:
            nextTurn.gameState = .start
            
        case .tapResume:
            nextTurn.gameState = .active
        
        case .tapRestart:
            shouldChangeWord = true
            remainingWords = WBDataManager.getAllWords()
            currentTurn = WBTurn.init(
                score: 0,
                activeLives: 3,
                turnWord:getRandomTurnWord(),
                gameState: .welcome)
            nextTurn = currentTurn

            nextTurn.gameState = .start
            
        case .collision:
            shouldChangeWord = true
            nextTurn.gameState = .lost
            nextTurn.activeLives -= 1
            
        case .tapTick:
            if(Manager.currentTurn.turnWord.isMatching) {
                nextTurn.score += WBGameConfig.scorePerWord.intValue
                nextTurn.gameState = .won
                if nextTurn.score > highScore {
                    highScore = nextTurn.score
                    UserDefaults.standard.set(highScore, forKey: "wbhighscore")
                    let _ = UserDefaults.synchronize(.standard)
                }
            }
            else {
                nextTurn.activeLives -= 1
                nextTurn.gameState = .lost
            }
            shouldChangeWord = true
            
            
        case .tapCross:
            if(Manager.currentTurn.turnWord.isMatching) {
                nextTurn.gameState = .lost
                nextTurn.activeLives -= 1
            }
            else {
                nextTurn.score += WBGameConfig.scorePerWord.intValue
                nextTurn.gameState = .won
                if nextTurn.score > highScore {
                    highScore = nextTurn.score
                }
            }
            shouldChangeWord = true
            
        case .tapScreen:
            if currentTurn.gameState == .won || currentTurn.gameState == .lost {
                nextTurn.gameState = .active
            }
        }
        
        //game over
        if(nextTurn.gameState == .lost) {
            if (nextTurn.activeLives <= 0) {
                nextTurn.gameState = .gameover
            }
        }
        
        //new word
        if (shouldChangeWord) {
            if(nextTurn.gameState == .won) {
                //FIXME:NEXT WORD
                //WBGameManager.currentTurn.turnWord.bottomWord.isDone = true
            }
            
            Manager.currentTurn.turnWord = Manager.getRandomTurnWord()
        }
        
        //did change state
        let didChangeState = currentTurn.gameState != nextTurn.gameState ||
            previousTurn!.gameState == WBGameState.gameover
        
        previousTurn = currentTurn
        currentTurn = nextTurn
        
        if didChangeState {
            //notification broadcast
            let updateNotification = Notification.init(name: .gameManager)
            NotificationCenter.default.post(updateNotification)
        }
    }
}
