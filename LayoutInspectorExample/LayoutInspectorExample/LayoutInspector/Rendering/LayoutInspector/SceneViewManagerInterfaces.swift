//
//  SceneViewManagerInterfaces.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/2/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import SceneKit

protocol SceneViewManagerProtocol {
    var sceneView: SCNView { get }
    var delegate: SceneViewManagerDelegate? { get set}
    func resetPointOfViewToDefaults()
    func handleTap(_ sender: UITapGestureRecognizer)
}

protocol SceneViewManagerDelegate: NSObjectProtocol {
    func selectedViewMetadataDidUpdate(_ metadata: ViewMetadataProtocol?)
}
