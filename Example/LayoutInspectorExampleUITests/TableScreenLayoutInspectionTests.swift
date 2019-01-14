//
//  TableScreenLayoutInspectionTests.swift
//  LayoutInspectorExampleUITests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest

class TableScreenLayoutInspectionTests: LIUITestCase {
    
    func testTablePageLayoutInpection() {
        // when
        tabScreen.tapTableTabButton()
        tableScreen.tapInspectionButton()
        // then
        XCTAssert(app.isDisplayingLayoutInspection, "LI should be visible")
        
        // when
        layoutInspectorScreen.tapCloseButton()
        // then
        XCTAssert(app.isDisplayingLayoutInspection == false, "LI should not be visible")
    }

}
