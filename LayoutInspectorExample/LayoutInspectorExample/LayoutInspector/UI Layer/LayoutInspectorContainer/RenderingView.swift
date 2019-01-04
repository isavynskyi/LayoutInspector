//
//  RenderingView.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/26/18.
//  Copyright © 2018 Ihor Savynskyi. All rights reserved.
//

import SceneKit

protocol RenderingViewProtocol {
    var viewNode: SCNNode? { get }
    var viewDescription: ViewDescriptionProtocol { get }
    var subviews: [RenderingViewProtocol]? { get }
}

struct RenderingView: RenderingViewProtocol {
    let viewNode: SCNNode?
    let viewDescription: ViewDescriptionProtocol
    let subviews: [RenderingViewProtocol]?
}
