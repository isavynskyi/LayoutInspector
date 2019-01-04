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

fileprivate enum SceneConstants {
    static let pointsInSceneKitMeter: Float = 100.0
    static let layerStep: Float = 0.3
}

class RenderingTreeBuilder: RenderingTreeBuilderProtocol {
    func build(from viewDescription: ViewDescriptionProtocol) -> RenderingViewProtocol {
        let renderingSubviews = viewDescription.subviews?.compactMap { build(from: $0) }
        var viewNode: SCNNode?
        
        // skip nodes for hidden views
        if viewDescription.isHidden == false {
            viewNode = node(for: viewDescription)
            adjustNodePositionToSceneKitCoordinateSystem(viewNode, with: viewDescription)
            renderingSubviews?.forEach({
                guard let node = $0.viewNode else { return }
                viewNode?.addChildNode(node)
            })
        }
        return RenderingView(viewNode: viewNode,
                             viewDescription: viewDescription,
                             subviews: renderingSubviews)
    }
}

private extension RenderingTreeBuilder {
    func node (for viewDescription: ViewDescriptionProtocol) -> SCNNode {
        let viewPlane = plane(for: viewDescription)
        let node = DebugNode()
        node.geometry = viewPlane
        node.metadata = ViewMetadata(with: viewDescription)
        return node
    }
    
    func plane(for viewDescription: ViewDescriptionProtocol) -> SCNPlane {
        let plane = SCNPlane(width: viewDescription.frame.size.width/CGFloat(SceneConstants.pointsInSceneKitMeter),
                             height: viewDescription.frame.size.height/CGFloat(SceneConstants.pointsInSceneKitMeter))
        if viewDescription.isTransparent {
            plane.firstMaterial?.diffuse.contents = UIImage(named: "transparent_view_image",
                                                            in: Bundle.layoutInspectorBundle,
                                                            compatibleWith: nil)
        } else {
            plane.firstMaterial?.diffuse.contents = viewDescription.snapshotImage
        }
        plane.firstMaterial?.isDoubleSided = true
        return plane
    }
    
    
/**
  SceneKit axes    SceneKit node center
  |y                 ___________
  |                 |           |
  |____x            |     *(0,0)|
z/                  |___________|
  
Point (0,0) is top left in UIKit whereas in SceneKit it is center
*/
func adjustNodePositionToSceneKitCoordinateSystem(_ node: SCNNode?, with viewDescription: ViewDescriptionProtocol) {
    guard let parentSize = viewDescription.parentSize, let node = node else { return }
    let viewCenter = viewDescription.center
    let translatedX = -parentSize.width/2.0 + viewCenter.x
    let translatedY = parentSize.height/2.0 - viewCenter.y
    node.position = SCNVector3Make(Float(translatedX)/SceneConstants.pointsInSceneKitMeter,
                                   Float(translatedY)/SceneConstants.pointsInSceneKitMeter,
                                   SceneConstants.layerStep)
    }
}

