//
//  LayoutInspectorPresenterTests.swift
//  LayoutInspectorExampleTests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest
@testable import LayoutInspector

class LayoutInspectorPresenterTests: XCTestCase {

    func testInteractionWithDelegate() {
        // given
        let presenteUnderTest = LayoutInspectorPresenter()
        let mockDelegate = LayoutInspectorPresenterDelegateMock()
        presenteUnderTest.delegate = mockDelegate
        // when, then
        XCTAssert(mockDelegate.didFinishLayoutInspectionCalledCount == 0)
        presenteUnderTest.didCloseAction()
        XCTAssert(mockDelegate.didFinishLayoutInspectionCalledCount == 1, "Didn't propagate close action to delegate")
    }
}
