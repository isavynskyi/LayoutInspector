//
//  XCTestCase+Extensions.swift
//  LayoutInspectorExampleUITests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func waitForElementToExist(element: XCUIElement, timeout: Double = 10) {
        expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: timeout, handler: nil)
    }
}
