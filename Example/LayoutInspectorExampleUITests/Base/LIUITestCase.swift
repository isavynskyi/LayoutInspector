//
//  LIUITestCase.swift
//  LayoutInspectorExampleUITests
//
//  Created by Igor Savynskyi on 1/13/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import Foundation
import XCTest

class LIUITestCase: XCTestCase {
    var app: XCUIApplication!
    var tabScreen: TabScreenObject!
    var tableScreen: TableScreenObject!
    var controlsScreen: ControlsScreenObject!
    var layoutInspectorScreen: LayoutInspectorContainerScreenObject!
    
    override func setUp() {        
        app = XCUIApplication()
        continueAfterFailure = false
        
        tabScreen = TabScreenObject(application: app, testCase: self)
        tableScreen = TableScreenObject(application: app, testCase: self)
        controlsScreen = ControlsScreenObject(application: app, testCase: self)
        layoutInspectorScreen = LayoutInspectorContainerScreenObject(application: app, testCase: self)
        XCUIApplication().launch()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        app.terminate()
        app = nil
        tabScreen = nil
        tableScreen = nil
        layoutInspectorScreen = nil
    }
}
