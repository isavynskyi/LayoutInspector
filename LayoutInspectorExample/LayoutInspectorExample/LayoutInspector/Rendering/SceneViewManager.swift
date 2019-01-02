//
//  SceneViewManager.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/2/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import SceneKit

fileprivate enum CameraParameters {
    static let orthographicScale = 4.0
    static let zNear = 0.0
    static let zFar = 100.0
}

class SceneViewManager: SceneViewManagerProtocol {
    let sceneView: SCNView
    weak var delegate: SceneViewManagerDelegate?
    
    private var selectedNode: DebugNode?

    init(sceneView: SCNView) {
        self.sceneView = sceneView
        configureSceneView()
    }
    
    func resetPointOfViewToDefaults() {
        sceneView.pointOfView?.position = SCNVector3(0, 0, 10)
        sceneView.pointOfView?.eulerAngles = SCNVector3()
        sceneView.pointOfView?.camera?.orthographicScale = CameraParameters.orthographicScale
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        let location: CGPoint = sender.location(in: sceneView)
        let hits = sceneView.hitTest(location, options: nil)
        if let tappedNode = hits.first?.node as? DebugNode {
            setSelectedNode(tappedNode)
        }
    }
}

// MARK: - Private API
private extension SceneViewManager {
    func configureSceneView() {
        sceneView.allowsCameraControl = true
        sceneView.scene = SCNScene()
        sceneView.scene?.background.contents = UIColor.sceneBackground
        sceneView.pointOfView = createCameraNode()
        resetPointOfViewToDefaults()
    }
    
    func createCameraNode() -> SCNNode {
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.zNear = CameraParameters.zNear
        camera.zFar = CameraParameters.zFar
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        return cameraNode
    }
    
    private func setSelectedNode(_ newSelectedNode: DebugNode) {
        // reset currently selected node if needed
        if selectedNode != nil, selectedNode != newSelectedNode {
            selectedNode?.isSelected = false
        }
        
        newSelectedNode.isSelected = !newSelectedNode.isSelected
        if selectedNode == newSelectedNode {
            selectedNode = nil
        } else {
            selectedNode = newSelectedNode
        }
        delegate?.selectedViewMetadataDidUpdate(selectedNode?.metadata)
    }

}
