//
//  pictureTapeUITests.swift
//  pictureTapeUITests
//
//  Created by Владимир Клевцов on 20.10.23..
//

import XCTest
import WebKit
import UIKit
import pictureTape

final class pictureTapeUITests: XCTestCase {
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        let isUITest = ProcessInfo.processInfo.environment["isUITest"]
        if isUITest == "true" {
            app.launchEnvironment = ["isUITest": "true"]
        }
        
        app.launch()
    }
    func testAuth() throws {
        app.buttons["Authenticate"].tap()
        
        let webView = app.webViews["UnsplashWebView"]
        
        XCTAssertTrue(webView.waitForExistence(timeout: 5))
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))
        loginTextField.tap()
        loginTextField.typeText("zonda4242@gmail.com")
        app.children(matching: .window).element(boundBy: 0).tap()
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))
        passwordTextField.tap()
        passwordTextField.typeText("kedby0-fupquz-Vegwur")
        sleep(2)
        app.children(matching: .window).element(boundBy: 0).tap()
        
        app.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }
    func testFeed() throws {
        let tablesQuery = app.tables
        
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp(velocity: .slow)
        
        sleep(2)
        
        let cellToLike = tablesQuery.children(matching: .cell).element(boundBy: 1)
        
        cellToLike.buttons["likeButton"].tap()
        sleep(5)
        cellToLike.buttons["like_button"].tap()
        sleep(4)
        cellToLike.tap()
        
        
        let image = app.scrollViews.images.element(boundBy: 0)
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)
        
        let navBackButtonWhiteButton = app.buttons["nav back button white"]
        navBackButtonWhiteButton.tap()
    }
    func testProfile() throws {
        sleep(3)
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.staticTexts["Vladimir Klevtsov"].exists)
        XCTAssertTrue(app.staticTexts["apathykid"].exists)
        
        app.buttons["logout button"].tap()
        
        app.alerts["Пока, пока!"].scrollViews.otherElements.buttons["Да"].tap()
    }
}
//        cellToLike.buttons["like_button"].tap()
//cellToLike.buttons["like_button_nil"].tap()
