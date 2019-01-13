//
//  LayoutInspectorContainerViewControllerTests.swift
//  LayoutInspectorExampleTests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest
@testable import LayoutInspector

class LayoutInspectorContainerViewControllerTests: XCTestCase {
    
    var vcUnderTest: LayoutInspectorContainerViewController?

    override func setUp() {
        vcUnderTest = ViewControllerFactory.createLayoutInspectorContainerViewController()
    }

    override func tearDown() {
        vcUnderTest = nil
    }

    func testInteractionWithOutput() {
        // givel
        let output = LayoutInspectorViewOutputMock()
        vcUnderTest?.output = output
        // when, then
        XCTAssert(output.didCloseCalledCount == 0)
        vcUnderTest?.didCloseAction()
        XCTAssert(output.didCloseCalledCount == 1, "Didn't propagate close action to output")
    }

}
