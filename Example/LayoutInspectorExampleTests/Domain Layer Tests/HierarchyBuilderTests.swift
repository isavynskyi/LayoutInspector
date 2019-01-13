//
//  HierarchyBuilderTests.swift
//  LayoutInspectorExampleTests
//
//  Created by Igor Savynskyi on 1/12/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest
@testable import LayoutInspector

class HierarchyBuilderTests: XCTestCase {

    func testHierarchyCapturing() {
        // given
        let builderUnderTest = HierarchyBuilder()
        // when
        let result = builderUnderTest.captureHierarchy()
        // then
        XCTAssertNotNil(result, "Hierarchy should exist")
        XCTAssertEqual(result?.className, "UIWindow", "Root element should be of class UIWindow")
        XCTAssertNotNil(result?.subviews, "Root element shoud have subviews")
        XCTAssert(result!.subviews!.count > 0, "UIWindow shoud have at least one subview")
        XCTAssert(result!.frame.origin == CGPoint.zero, "UIWindow shoud start from (0, 0) point")
    }

}

