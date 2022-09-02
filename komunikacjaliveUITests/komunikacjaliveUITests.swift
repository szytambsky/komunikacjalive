//
//  komunikacjaliveUITests.swift
//  komunikacjaliveUITests
//
//  Created by Szymon Tamborski on 01/09/2022.
//

import XCTest
import SwiftUI

class komunikacjaliveUITests: XCTestCase {

    override func setUpWithError() throws {
        super.setUp()
        let app = XCUIApplication()
        app.setIsAppOnboarding(false)
        app.launch()
        continueAfterFailure = false
        sleep(10)
        
        addUIInterruptionMonitor(withDescription: "Automatically allow location permissions") { alert in
            sleep(2)
            let button = alert.buttons["Allow"]
            if button.exists {
                button.tap()
                return true
            }
            return false
        }
    }

    override func tearDown() {
        super.tearDown()
        XCUIApplication().terminate()
    }
    
    func test_IfRightPanelSearchButtonIsAvailable() {
        XCTAssert(PageObject.rightPanelSearchButton.exists)
    }
    
    func test_IfButtonsAreTappableAndUntappableAfterNavigatedToSearchLinesView() throws {
        XCTAssert(PageObject.rightPanelSearchButton.isEnabled == true)
        
        PageObject.rightPanelSearchButton.tap()
        
        XCTAssert(PageObject.rightPanelSearchButton.isEnabled == true)
    }
}


// MARK: - XCUIApplication

extension XCUIApplication {
    func setIsAppOnboarding(_ isOnboarding: Bool = false) {
        launchArguments += ["-isOnboarding", isOnboarding ? "true" : "false"]
    }
}
