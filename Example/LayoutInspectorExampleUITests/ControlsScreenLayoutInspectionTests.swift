//
//  ControlsScreenLayoutInspectionTests.swift
//  LayoutInspectorExampleUITests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest

class ControlsScreenLayoutInspectionTests: LIUITestCase {
    
    func testControlsPageLayoutInpection() {
        // when
        tabScreen.tapControlsTabButton()
        controlsScreen.tapInspectionButton()
        // then
        XCTAssert(app.isDisplayingLayoutInspection, "LI should be visible")
        
        // when
        layoutInspectorScreen.tapCloseButton()
        // then
        XCTAssert(app.isDisplayingLayoutInspection == false, "LI should not be visible")
    }
}
