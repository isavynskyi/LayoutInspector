//
//  LayoutInspectorFacadeTests.swift
//  LayoutInspectorExampleTests
//
//  Created by Igor Savynskyi on 1/12/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest
@testable import LayoutInspector

class LayoutInspectorFacadeTests: XCTestCase {

    func testSubscriptionForScreenshotNotification() {
        // given
        let sharedInspectorUnderTest = LayoutInspector.shared
        let notificationCenter = NotificationCenter.default
        let screenshotNotificationName = UIApplication.userDidTakeScreenshotNotification.rawValue
        // when, then
        sharedInspectorUnderTest.setAutoTrigger(.none)
        XCTAssertFalse(notificationCenter.debugDescription.contains(screenshotNotificationName), "Screenshot notification should not have subscribers")

        sharedInspectorUnderTest.setAutoTrigger(.screenshot)
        XCTAssertTrue(notificationCenter.debugDescription.contains(screenshotNotificationName), "Screenshot notification should have subscribers")
    }
    func testSubscriptionForShake() {
        // given
        let sharedInspectorUnderTest = LayoutInspector.shared
		
        // when, then
        sharedInspectorUnderTest.setAutoTrigger(.none)
		XCTAssertFalse(UIResponder.motionEnded_ShakeIMP == class_getMethodImplementation(UIResponder.self, #selector(UIResponder.motionEnded(_:with:))))

        sharedInspectorUnderTest.setAutoTrigger(.shake)
		XCTAssertNotNil(UIResponder.motionEnded_ShakeIMP)
		XCTAssertTrue(UIResponder.motionEnded_ShakeIMP == class_getMethodImplementation(UIResponder.self, #selector(UIResponder.motionEnded(_:with:))))
    }
}
