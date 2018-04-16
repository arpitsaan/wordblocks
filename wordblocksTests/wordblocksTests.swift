//
//  wordblocksTests.swift
//  wordblocksTests
//
//  Created by Arpit Agarwal on 12/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import XCTest
@testable import wordblocks

class wordblocksTests: XCTestCase {
    override func setUp() {
        super.setUp()
        Manager.beginGame()
    }
    
    //------------------
    // gamestart tests
    //------------------
    func testWordsJSONDataIsLoaded() {
        XCTAssert(WBDataManager.getAllWords().count > 0, "expect JSON file loads on game start")
    }
    
    func testUserScoreIsZeroOnGameStart() {
        XCTAssert(Manager.currentTurn.activeLives > 0, "expect user has no score on game start")
    }
    
    func testGameHasLivesOnStart() {
        XCTAssert(Manager.currentTurn.activeLives > 0, "expect user has lives to play on game start")
    }
    
    func testGameHasNonEmptyTopAndBottomWordsOnStart() {
        XCTAssert(Manager.currentTurn.turnWord.topWordText.count > 0 , "expect top word is not empty on game start")
        XCTAssert(Manager.currentTurn.turnWord.bottomWordText.count > 0 , "expect bottom word is not empty on game start")
    }
    
    //------------------
    // gameplay tests
    //------------------
    func testUserLostALifeWhenYesTappedOnNonMatchingWords() {
        Manager.currentTurn.activeLives = 3
        Manager.currentTurn.turnWord.isMatching = false
        Manager.updateTurn(action: .tapTick)
        
        //check updated turn
        XCTAssert(Manager.currentTurn.activeLives == 2 , "expect user loses a life when he answers correct on ")
    }
    
    func testUserScoreIncreasesWhenTappedNoOnNonMatchingWords() {
        //Setup
        Manager.currentTurn.score = 10
        Manager.currentTurn.turnWord.isMatching = false
        
        //Execution
        Manager.updateTurn(action: .tapCross)
        
        //Expectation
        XCTAssert(Manager.currentTurn.score > 10 , "expect user score increases when tapped NO on NON-Matching Words (correct ans)")
    }
    
    func testHighScoreIsGettingUpdated() {
        //Setup
        Manager.highScore = 10
        Manager.currentTurn.score = 10
        
        //Execution
        Manager.currentTurn.turnWord.isMatching = true
        Manager.updateTurn(action: .tapTick)
        
        Manager.updateTurn(action: .tapScreen)
        
        Manager.currentTurn.turnWord.isMatching = true
        Manager.updateTurn(action: .tapTick)
        
        //Expectation
        XCTAssert(Manager.currentTurn.score > 10 , "expect user loses a life when he answers correct on ")
    }
    
    //-----------------------------------------------------------------------
    // Super Win State (user answers everything correctly)
    //-----------------------------------------------------------------------
    func testGameReachesSuperWinStateWhenDataSetGetsEmptied() {
        //Setup
        Manager.remainingWords = []
        
        //Execution
        Manager.currentTurn.turnWord.isMatching = true
        Manager.updateTurn(action: .tapTick)
        Manager.updateTurn(action: .tapScreen)
        
        //Expectation
        XCTAssert(Manager.currentTurn.gameState == .superWin , "expect the game to reach a super win state when no words are left to practice")
    }
    
}
