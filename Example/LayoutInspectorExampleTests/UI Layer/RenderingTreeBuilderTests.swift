//
//  RenderingTreeBuilderTests.swift
//  LayoutInspectorExampleTests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest
@testable import LayoutInspector

class RenderingTreeBuilderTests: XCTestCase {
    
    func testBuildResultForMockViewDescription() {
        // given
        let builderUnderTest = RenderingTreeBuilder()
        let mockViewDescription: ViewDescriptionProtocol = ViewDescription(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 49.0),
                                                                           snapshot: nil,
                                                                           subviews: nil,
                                                                           parentSize: CGSize(width: 375.0, height: 50.0),
                                                                           center: CGPoint(x: 187.5, y: 24.75),
                                                                           isHidden: false,
                                                                           isTransparent: true,
                                                                           className: "UITableViewCellContentView",
                                                                           isUserInteractionEnabled: true,
                                                                           alpha: 1.0,
                                                                           backgroundColor: nil,
                                                                           tint: nil,
                                                                           clipToBounds: false)
        // when
        let renderingView = builderUnderTest.build(from: mockViewDescription)
        // then
        XCTAssert(renderingView.viewNode != nil, "RenderingView's viewNode should exist")
        XCTAssert(renderingView.viewDescription.subviews?.count == mockViewDescription.subviews?.count, "RenderingView's created subviews count should be equal to the source viewDesctiption subview count")
    }
    
}
