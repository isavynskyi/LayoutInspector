//
//  LayoutInspectorViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit
import SceneKit

fileprivate enum CameraParameters {
    static let orthographicScale = 4.0
    static let zNear = 0.0
    static let zFar = 100.0
}

class LayoutInspectorViewController: UIViewController {
    var output: LayoutInspectorViewOutput?
    
    @IBOutlet private weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    // MARK: - Private API
    private func configure() {
        sceneView.allowsCameraControl = true
        sceneView.scene = SCNScene()
        sceneView.scene?.background.contents = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        sceneView.pointOfView = createCameraNode()
        resetPointOfViewToDefaults(sceneView.pointOfView)
    }
    
    private func createCameraNode() -> SCNNode {
        let camera = SCNCamera()
        camera.usesOrthographicProjection = true
        camera.zNear = CameraParameters.zNear
        camera.zFar = CameraParameters.zFar
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        return cameraNode
    }
    
    private func resetPointOfViewToDefaults(_ cameraNode: SCNNode?) {
        sceneView.pointOfView?.position = SCNVector3(0, 0, 10)
        sceneView.pointOfView?.eulerAngles = SCNVector3()
        sceneView.pointOfView?.camera?.orthographicScale = CameraParameters.orthographicScale
    }
    
    //MARK: - Actions
    @IBAction private func closeAction(_ sender: Any) {
        output?.didCloseAction()
    }
    
    @IBAction func resetCameraPositionAction(_ sender: Any) {
        resetPointOfViewToDefaults(sceneView.pointOfView)
    }
}

extension LayoutInspectorViewController: LayoutInspectorViewInput {
    func rootView() -> UIView {
        return view
    }
    
    func addNodeToScene(_ node: SCNNode) {
        sceneView.scene?.rootNode.addChildNode(node)
    }
    
    func removeNode(_ node: SCNNode) {
        node.removeFromParentNode()
    }
}
