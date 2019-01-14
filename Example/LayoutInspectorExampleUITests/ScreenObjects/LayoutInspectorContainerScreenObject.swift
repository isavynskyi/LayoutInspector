//
//  LayoutInspectorContainerScreenObject.swift
//  LayoutInspectorExampleUITests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import Foundation
import XCTest

class LayoutInspectorContainerScreenObject: ScreenObject {
    private var closeButton: XCUIElement

    override init (application: XCUIApplication, testCase: XCTestCase) {
        closeButton = application.buttons["close"]
        super.init(application: application, testCase: testCase)
    }
    
    func tapCloseButton() {
        tc.waitForElementToExist(element: closeButton)
        closeButton.tap()
    }
}
