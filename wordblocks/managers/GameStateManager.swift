//
//  GameStateManager.swift
//  wordblocks
//
//  Created by Arpit Agarwal on 14/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import UIKit

class GameStateManager: NSObject {
    //shared manager
    static let sharedInstance = GameStateManager()
    
    override init() {
        super.init()
    }
    
    func startNewGame() {
        CurrentGameManager.sharedInstance.increaseTurnCount()
    }
    
    func gameResumed() {
        
    }
}
