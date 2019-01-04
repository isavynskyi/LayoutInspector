//
//  MenuWidgetInterfaces.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/3/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import Foundation

protocol MenuWidgetProtocol {
    var delegate: MenuWidgetDelegate? { get set }
}

protocol MenuWidgetDelegate: NSObjectProtocol {
    func didCloseAction()
    func didResetCameraPositionAction()
}
