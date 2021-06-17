//
//  UITests.swift
//  
//
//  Created by Jevon Mao on 6/15/21.
//

import Foundation
import XCTest

final class UITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["testing"]
        app.launch()
    }
    
    func testTitle() {
        //XCTAssertTrue(app.staticTexts["Hello World!"].exists)
    }
}
