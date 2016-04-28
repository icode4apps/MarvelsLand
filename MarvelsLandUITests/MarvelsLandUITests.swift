//
//  MarvelsLandUITests.swift
//  MarvelsLandUITests
//
//  Created by Joao Batista Rocha Jr. on 20/04/16.
//  Copyright © 2016 Joao Batista Rocha Jr. All rights reserved.
//

import XCTest

class MarvelsLandUITests: XCTestCase {
        
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
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.buttons["Go"].tap()
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        
        let backButton = app.navigationBars["MarvelsLand.MarvelsDetailView"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0)
        backButton.tap()
        
        let marvelslandMarvelslisttableviewNavigationBar = app.navigationBars["MarvelsLand.MarvelsListTableView"]
        let searchButton = marvelslandMarvelslisttableviewNavigationBar.buttons["Search"]
        searchButton.tap()
        app.typeText("C")
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        backButton.tap()
        
        let typeHereSearchField = marvelslandMarvelslisttableviewNavigationBar.searchFields["Type here..."]
        let clearTextButton = typeHereSearchField.buttons["Clear text"]
        clearTextButton.tap()
        app.typeText("J")
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        backButton.tap()
        typeHereSearchField.tap()
        app.typeText("a")
        
        let element = app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        element.tap()
        
        let cancelButton = marvelslandMarvelslisttableviewNavigationBar.buttons["Cancel"]
        cancelButton.tap()
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        tablesQuery.staticTexts["Absorbing Man"].tap()
        tablesQuery.buttons[">"].tap()
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        backButton.tap()
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        tablesQuery.staticTexts["Angel (Thomas Halloway)"].tap()
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        backButton.tap()
        searchButton.tap()
        app.typeText("C")
        tablesQuery.staticTexts["Cable (Marvel: Avengers Alliance)"].swipeUp()
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        tablesQuery2.cells.containingType(.StaticText, identifier:"Captain Marvel (Monica Rambeau)").childrenMatchingType(.StaticText).matchingIdentifier("Captain Marvel (Monica Rambeau)").elementBoundByIndex(0).tap()
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        
        let element2 = element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element
        element2.childrenMatchingType(.Button).matchingIdentifier("Link").elementBoundByIndex(0).tap()
        XCUIDevice.sharedDevice().orientation = .Portrait
        XCUIDevice.sharedDevice().orientation = .Portrait
        
        let backToMarvelslandButton = app.statusBars.buttons["Back to MarvelsLand"]
        backToMarvelslandButton.tap()
        XCUIDevice.sharedDevice().orientation = .Portrait
        XCUIDevice.sharedDevice().orientation = .Portrait
        element2.childrenMatchingType(.Button).matchingIdentifier("Link").elementBoundByIndex(1).tap()
        XCUIDevice.sharedDevice().orientation = .Portrait
        XCUIDevice.sharedDevice().orientation = .Portrait
        XCUIDevice.sharedDevice().orientation = .Portrait
        XCUIDevice.sharedDevice().orientation = .Portrait
        element2.childrenMatchingType(.Button).matchingIdentifier("Link").elementBoundByIndex(2).tap()
        XCUIDevice.sharedDevice().orientation = .Portrait
        XCUIDevice.sharedDevice().orientation = .Portrait
        backToMarvelslandButton.tap()
        XCUIDevice.sharedDevice().orientation = .Portrait
        XCUIDevice.sharedDevice().orientation = .Portrait
        backButton.tap()
        clearTextButton.tap()
        cancelButton.tap()
        // Failed to find matching element please file bug (bugreport.apple.com) and provide output from Console.app
        
    }
    
    
}
