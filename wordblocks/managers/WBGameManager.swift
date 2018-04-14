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
    case started
    case active
    case paused
    case won
    case lost
    case gameover
}

class WBGameManager: NSObject {
    private static var highScore:Int = 0
    private static var currentTurn = WBTurn()
    private static var allWords = [WBWord]()
    private static var remaningWords = [WBWord]()
    
    //next turn method
    public static func getNextTurn(action:WBUserAction, turn:WBTurn) -> WBTurn {
        
        var nextTurn = turn
        
        switch action {
            case .tapStart: nextTurn.gameState = .started
            case .tapPause: nextTurn.gameState = .paused
            case .tapResume: nextTurn.gameState = .paused
            case .tapRestart:
                nextTurn.gameState = .welcome
            case .tapTick: break
            case .tapCross: break
            case .tapScreen: break
            case .exitGame: break
        }
        
        
        return nextTurn
    }
    
    
}
