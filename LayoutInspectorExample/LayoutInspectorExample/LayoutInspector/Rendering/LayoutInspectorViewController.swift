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
    private var tapGestureRecognizer: UITapGestureRecognizer {
        return UITapGestureRecognizer.init(target: self, action: #selector(handleTap(_:)))
    }
    private var selectedNode: DebugNode?
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    
    // MARK: - Private API
    private func configure() {
        configureSceneView()
        configureGestures()
    }
    
    private func configureSceneView() {
        sceneView.allowsCameraControl = true
        sceneView.scene = SCNScene()
        sceneView.scene?.background.contents = UIColor.sceneBackground
        sceneView.pointOfView = createCameraNode()
        resetPointOfViewToDefaults(sceneView.pointOfView)
        sceneView.delegate = self
    }
    
    private func configureGestures() {
        view.addGestureRecognizer(tapGestureRecognizer)
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
    
    private func setSelectedNode(_ newSelectedNode: DebugNode) {
        if selectedNode != nil, selectedNode != newSelectedNode {
            selectedNode?.isSelected = false
        }
        
        newSelectedNode.isSelected = !newSelectedNode.isSelected
        selectedNode = newSelectedNode
        
        if selectedNode?.isSelected == false {
            selectedNode = nil
        }
    }
    
    //MARK: - Actions
    @IBAction private func closeAction(_ sender: Any) {
        output?.didCloseAction()
    }
    
    @IBAction func resetCameraPositionAction(_ sender: Any) {
        resetPointOfViewToDefaults(sceneView.pointOfView)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        let location: CGPoint = sender.location(in: view)
        let hits = sceneView.hitTest(location, options: nil)
        if let tappedNode = hits.first?.node as? DebugNode {
            setSelectedNode(tappedNode)
        }
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


extension LayoutInspectorViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
            print(sceneView.pointOfView?.eulerAngles)
    }

}
