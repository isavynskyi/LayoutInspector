//
//  LayoutInspectorPresenterDelegateMock.swift
//  LayoutInspectorExampleTests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import Foundation
@testable import LayoutInspector

class LayoutInspectorPresenterDelegateMock: NSObject, LayoutInspectorPresenterDelegate {
    private(set) var didFinishLayoutInspectionCallsCounter = 0
    
    func didFinishLayoutInspection() {
        didFinishLayoutInspectionCallsCounter += 1
    }
}
