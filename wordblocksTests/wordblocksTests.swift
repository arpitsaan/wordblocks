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
    // game start checks
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
    // game start checks
    //------------------
    
    func testPerformanceExample() {
        //TODO:view did appear in 10 seconds
        
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
