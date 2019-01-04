//
//  SceneWidgetInterfaces.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/3/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import SceneKit

protocol SceneWidgetProtocol: NodesManagementProtocol {
    var delegate: SceneViewManagerDelegate? { get set }
    func resetPointOfViewToDefaults()
}
