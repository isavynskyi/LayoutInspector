//
//  RenderingTreeBuilder.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/26/18.
//  Copyright © 2018 Ihor Savynskyi. All rights reserved.
//

import SceneKit

protocol RenderingTreeBuilderProtocol {
    func build(from: ViewDescriptionProtocol) -> RenderingViewProtocol
}

class RenderingTreeBuilder: RenderingTreeBuilderProtocol {
    func build(from viewDescription: ViewDescriptionProtocol) -> RenderingViewProtocol {
        let renderingSubviews = viewDescription.subviews?.compactMap {build(from: $0)}
        // TODO: - correct node position
        let viewNode = node(for: viewDescription)
        adjustNodePositionToSceneKitCoordinateSystem(viewNode, with: viewDescription)
        renderingSubviews?.forEach({ viewNode.addChildNode($0.viewNode)})
        return RenderingView(viewNode: viewNode, viewDescription: viewDescription, subviews: renderingSubviews)
    }
}

private extension RenderingTreeBuilder {
    func node (for viewDescription: ViewDescriptionProtocol) -> SCNNode {
        let viewPlane = plane(for: viewDescription)
        return SCNNode(geometry: viewPlane)
    }
    
    func plane(for viewDescription: ViewDescriptionProtocol) -> SCNPlane {
        let plane = SCNPlane(width: viewDescription.frame.size.width/CGFloat(Constants.pointsInSceneKitMeter),
                             height: viewDescription.frame.size.height/CGFloat(Constants.pointsInSceneKitMeter))
        plane.firstMaterial?.diffuse.contents = viewDescription.snapshot
        return plane
    }
    
    
/**
  SceneKit axis    SceneKit center
  |y              |           |
  |               |     *(0,0)|
  |____x          |___________|
*/
 func adjustNodePositionToSceneKitCoordinateSystem(_ node: SCNNode, with viewDescription: ViewDescriptionProtocol) {
    // TODO:   node.width instead of sourceViewFrame/CGFloat(Constants.pointsInSceneKitMeter)
    guard let parentSize = viewDescription.parentSize else { return }
    let viewCenter = viewDescription.center
    
    node.position = SCNVector3Make(Float((-parentSize.width/2.0 + viewCenter.x))/Float(Constants.pointsInSceneKitMeter),
                                   Float((parentSize.height/2.0 - viewCenter.y))/Float(Constants.pointsInSceneKitMeter),
                                   Float(Constants.layerStep))
    }
}
