//
//  XCUIApplication+Extensions.swift
//  LayoutInspectorExampleUITests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import Foundation
import XCTest

extension XCUIApplication {
    var isDisplayingLayoutInspection: Bool {
        return otherElements["LayoutInspectorContainerView"].exists
    }
}
