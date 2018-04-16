//
//  wordblocksUITests.swift
//  wordblocksUITests
//
//  Created by Arpit Agarwal on 12/04/18.
//  Copyright © 2018 acyooman. All rights reserved.
//

import XCTest

class wordblocksUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element

        app.alerts["Welcome to Word Blocks!"].buttons["🏁 Start Playing 🏁"].tap()
        
        let redButtonNormalButton = app.buttons["red button normal"]
        redButtonNormalButton.tap()
        element.tap()
        redButtonNormalButton.tap()
        element.tap()
        redButtonNormalButton.tap()
        element.tap()
        
        let greenButtonNormalButton = app.buttons["green button normal"]
        greenButtonNormalButton.tap()
        element.tap()
        greenButtonNormalButton.tap()
        element.tap()
        greenButtonNormalButton.tap()
        element.tap()
        greenButtonNormalButton.tap()
        element.tap()
       
    }
    
}
