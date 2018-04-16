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
    case collision //no user action
}

enum WBGameState {
    case welcome
    case start
    case active
    case won
    case lost
    case collision
    case gameover
    
    //TODO:V2
    //    case paused
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
        currentTurn = WBTurn.init(
            score: 0,
            activeLives: 3,
            turnWord:getRandomTurnWord(),
            gravityPercent: 1,
            gameState: .welcome)
        
        //notification broadcast - begin the game
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
    
    //Next Turn State Machine - Update turn based on Action
    public static func updateTurn(action:WBUserAction) {
        
        var nextTurn = currentTurn
        
        switch action {
        //game start
        case .tapStart:
            nextTurn.gameState = .start
        
        //TODO: V2 - pause state
        case .tapResume:
            nextTurn.gameState = .active
        
        //restart after game over
        case .tapRestart:
            remainingWords = WBDataManager.getAllWords()
            currentTurn = WBTurn.init(
                score: 0,
                activeLives: 3,
                turnWord:getRandomTurnWord(),
                gravityPercent: 1,
                gameState: .welcome)
            nextTurn = currentTurn

            nextTurn.gameState = .start
        
        //words collided
        case .collision:
            nextTurn.activeLives -= 1
            
            if (nextTurn.activeLives <= 0) {
                nextTurn.gameState = .gameover
            }
            else{
                nextTurn.gameState = .collision
            }
            
        //tap tick
        case .tapTick:
            if(Manager.currentTurn.turnWord.isMatching) {
                //FIXME:CREATE method correct
                nextTurn.score += WBGameConfig.scorePerWord.intValue
                nextTurn.gravityPercent += WBGameConfig.difficultyFactor.intValue
                nextTurn.gameState = .won
                nextTurn.turnWord = getRandomTurnWord()
                if nextTurn.score > highScore {
                    highScore = nextTurn.score
                    UserDefaults.standard.set(highScore, forKey: "wbhighscore")
                    let _ = UserDefaults.synchronize(.standard)
                }
            }
            else {
                //FIXME:CREATE method for incorrect
                nextTurn.activeLives -= 1
                
                if (nextTurn.activeLives <= 0) {
                    nextTurn.gameState = .gameover
                }
                else {
                    nextTurn.gameState = .lost
                    
                }
            }
            
           
        //tap cross
        case .tapCross:
            if(Manager.currentTurn.turnWord.isMatching) {
                //FIXME:CREATE method for incorrect
                nextTurn.activeLives -= 1
                
                if (nextTurn.activeLives <= 0) {
                    nextTurn.gameState = .gameover
                }
                else {
                    nextTurn.gameState = .lost
                    
                }
            }
            else {
                //FIXME:CREATE method correct
                nextTurn.score += WBGameConfig.scorePerWord.intValue
                nextTurn.gravityPercent += WBGameConfig.difficultyFactor.intValue
                nextTurn.gameState = .won
                nextTurn.turnWord = getRandomTurnWord()
                if nextTurn.score > highScore {
                    highScore = nextTurn.score
                    UserDefaults.standard.set(highScore, forKey: "wbhighscore")
                    let _ = UserDefaults.synchronize(.standard)
                }
            }
            
        //tap screen
        case .tapScreen:
            if currentTurn.gameState == .won
                || currentTurn.gameState == .lost
                || currentTurn.gameState == .collision {
                nextTurn.gameState = .active
            }
        }
        
        //check if change state
        let didChangeState = currentTurn.gameState != nextTurn.gameState
        
        previousTurn = currentTurn
        currentTurn = nextTurn
        
        if didChangeState {
            //notification broadcast
            let updateNotification = Notification.init(name: .gameManager)
            NotificationCenter.default.post(updateNotification)
        }
    }
}
