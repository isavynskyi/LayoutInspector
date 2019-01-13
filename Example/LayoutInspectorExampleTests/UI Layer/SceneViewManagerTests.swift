//
//  SceneViewManagerTests.swift
//  LayoutInspectorExampleTests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import XCTest
@testable import LayoutInspector
import SceneKit

class SceneViewManagerTests: XCTestCase {

    func testNodesManagementInScene() {
        // given
        let sceneView = SCNView()
        let managerUnderTest = SceneViewManager(sceneView: sceneView)
        let node = SCNNode()
        let sceneNodesInitialCount = sceneView.scene?.rootNode.childNodes.count ?? 0
        // when, then
        managerUnderTest.addNode(node)
        XCTAssert(sceneView.scene?.rootNode.childNodes.count == sceneNodesInitialCount + 1, "Wrong nodes count in scene")
        managerUnderTest.removeNode(node)
        XCTAssert(sceneView.scene?.rootNode.childNodes.count == sceneNodesInitialCount, "Wrong nodes count in scene")
    }
}
