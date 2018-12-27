//
//  LayoutInspectorViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit
import SceneKit

class LayoutInspectorViewController: UIViewController {
    var output: LayoutInspectorViewOutput?
    
    @IBOutlet weak var sceneView: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Actions
    @IBAction private func closeAction(_ sender: Any) {
        output?.didCloseAction()
    }
    
    func configure() {
        sceneView.allowsCameraControl = true
        sceneView.scene = SCNScene()
        sceneView.scene?.background.contents = #colorLiteral(red: 0.8199721342, green: 1, blue: 0.9764705896, alpha: 1)
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
