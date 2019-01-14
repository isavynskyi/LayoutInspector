//
//  ScreenObject.swift
//  LayoutInspectorExampleUITests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest

class ScreenObject {
    let app: XCUIApplication
    let tc: XCTestCase
    
    init (application: XCUIApplication, testCase: XCTestCase) {
        app = application
        tc = testCase
    }
}
