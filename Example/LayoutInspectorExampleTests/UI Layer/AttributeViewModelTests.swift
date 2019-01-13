//
//  AttributeViewModelTests.swift
//  LayoutInspectorExampleTests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest
@testable import LayoutInspector

class AttributeViewModelTests: XCTestCase {
    
    func testNilColorRepresentationString() {
        // given
        let attributeValue = AttributeValue.color(nil)
        let modelUnderTest = AttributeViewModel(title: "Color", value: attributeValue)
        // when
        let representationString = modelUnderTest.valueStringRepresentation
        // then
        XCTAssert(representationString == ColorRepresentationPattern.nilColor, "Wrong representation for nil color")
    }

    func testClearColorRepresentationString() {
        // given
        let attributeValue = AttributeValue.color(.clear)
        let modelUnderTest = AttributeViewModel(title: "Color", value: attributeValue)
        // when
        let representationString = modelUnderTest.valueStringRepresentation
        // then
        XCTAssert(representationString == ColorRepresentationPattern.clear, "Wrong representation for clear color")
    }

    func testCustomColorRepresentationString() {
        // given
        let color = UIColor.white
        let attributeValue = AttributeValue.color(color)
        let modelUnderTest = AttributeViewModel(title: "Color", value: attributeValue)
        // when
        let representationString = modelUnderTest.valueStringRepresentation
        // then
        let expectedString = String(format: ColorRepresentationPattern.regularColorFormat,
                                    color.redValue,
                                    color.greenValue,
                                    color.blueValue,
                                    color.alphaValue)
x        XCTAssert(representationString == expectedString, "Wrong representation for custom color")
    }
    
    func testRepresentationStringForCustomText() {
        // given
        let value = "Attribute value"
        let attributeValue = AttributeValue.text(value)
        let modelUnderTest = AttributeViewModel(title: "Attribute title", value: attributeValue)
        // when
        let representationString = modelUnderTest.valueStringRepresentation
        // then
        XCTAssert(representationString == value, "Wrong representation for attribute value string")
    }
    
    func testRepresentationStringForNilText() {
        // given
        let attributeValue = AttributeValue.text(nil)
        let modelUnderTest = AttributeViewModel(title: "Attribute title", value: attributeValue)
        // when
        let representationString = modelUnderTest.valueStringRepresentation
        // then
        XCTAssertNil(representationString, "Wrong representation for nil attribute string")
    }
}
