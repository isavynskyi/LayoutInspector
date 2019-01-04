//
//  RenderingViewDescription.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/26/18.
//  Copyright © 2018 Ihor Savynskyi. All rights reserved.
//

import Foundation
import SceneKit

protocol RenderingViewProtocol {
    var viewNode: SCNNode? {get}
    var viewDescription: ViewDescriptionProtocol {get}
    var subviews: [RenderingViewProtocol]? {get}
}

struct RenderingView: RenderingViewProtocol {
    var viewNode: SCNNode?
    var viewDescription: ViewDescriptionProtocol
    var subviews: [RenderingViewProtocol]?
}
