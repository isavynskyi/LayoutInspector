//
//  SceneWidgetViewControllerTests.swift
//  LayoutInspectorExampleTests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest
@testable import LayoutInspector

class SceneWidgetViewControllerTests: XCTestCase {
    var vcUnderTest: SceneWidgetViewController?
    
    override func setUp() {
        vcUnderTest = SceneWidgetViewController()
    }

    override func tearDown() {
        vcUnderTest = nil
    }

    func testInteractionWithDelegate() {
        // given
        let mockDelegate = SceneViewManagerDelegateMock()
        vcUnderTest?.delegate = mockDelegate
        let initialCallCount = mockDelegate.selectedViewMetadataDidUpdateCallsCounter
        // when
        vcUnderTest?.selectedViewMetadataDidUpdate(nil)
        // then
        XCTAssert(mockDelegate.selectedViewMetadataDidUpdateCallsCounter == initialCallCount + 1)
    }
}
