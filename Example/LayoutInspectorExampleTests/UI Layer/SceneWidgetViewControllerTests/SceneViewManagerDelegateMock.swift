//
//  SceneViewManagerDelegateMock.swift
//  LayoutInspectorExampleTests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

@testable import LayoutInspector

class SceneViewManagerDelegateMock: NSObject, SceneViewManagerDelegate {
     private(set) var selectedViewMetadataDidUpdateCallsCounter = 0

    func selectedViewMetadataDidUpdate(_ metadata: ViewMetadataProtocol?) {
        selectedViewMetadataDidUpdateCallsCounter += 1
    }

}
