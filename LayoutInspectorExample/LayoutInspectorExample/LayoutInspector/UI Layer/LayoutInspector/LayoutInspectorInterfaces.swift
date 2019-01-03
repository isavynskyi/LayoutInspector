//
//  LayoutInspectorInterfaces.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/3/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import SceneKit

protocol NodesManagementProtocol {
    func addNodeToScene(_ node: SCNNode)
    func removeNode(_ node: SCNNode)
}
