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
        let initialDidFinishLayoutInspectionCallsCount = mockDelegate.didFinishLayoutInspectionCallsCounter
        // when
        presenteUnderTest.didCloseAction()
        // then
        XCTAssert(mockDelegate.didFinishLayoutInspectionCallsCounter == initialDidFinishLayoutInspectionCallsCount + 1, "Didn't propagate close action to delegate")
    }
}
