//
//  LayoutInspectorViewOutputMock.swift
//  LayoutInspectorExampleTests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import Foundation
@testable import LayoutInspector

class LayoutInspectorViewOutputMock: LayoutInspectorViewOutput {
    var didCloseCalledCount = 0
    
    func didCloseAction() {
        didCloseCalledCount += 1
    }
}
