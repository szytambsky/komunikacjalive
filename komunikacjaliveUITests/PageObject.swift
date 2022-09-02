import Foundation
import XCTest

public struct PageObject {
    
    /// Set the proxy between tests and application - buttons[] is an abbreviation for  buttons.matching(identifier: "rightPanelSearchButton")
    public static let rightPanelSearchButton = XCUIApplication().buttons["rightPanelSearchButton"]
    
}
