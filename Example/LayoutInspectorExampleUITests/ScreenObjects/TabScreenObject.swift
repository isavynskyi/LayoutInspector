//
//  TabScreenObject.swift
//  LayoutInspectorExampleUITests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import Foundation
import XCTest

class TabScreenObject: ScreenObject {
    private var featuredTabButton: XCUIElement
    private var moreTabButton: XCUIElement

    override init (application: XCUIApplication, testCase: XCTestCase) {
        featuredTabButton = application.tabBars.buttons["Featured"]
        moreTabButton = application.tabBars.buttons["More"]
        super.init(application: application, testCase: testCase)
    }
    
    func tapTableTabButton() {
        featuredTabButton.tap()
    }
    
    func tapControlsTabButton() {
        moreTabButton.tap()
    }
}
