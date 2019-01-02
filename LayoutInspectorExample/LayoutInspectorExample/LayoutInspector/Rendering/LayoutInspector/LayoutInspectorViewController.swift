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
    // Props
    var output: LayoutInspectorViewOutput?
    private var sceneViewManager: SceneViewManagerProtocol!
    private var tapGestureRecognizer: UITapGestureRecognizer {
        return UITapGestureRecognizer.init(target: self, action: #selector(handleTap(_:)))
    }
    private var objectInspectionWidget: ObjectInspectionManagerProtocol?
    
    // Outlets
    @IBOutlet private weak var sceneView: SCNView!
     
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        sceneViewManager = SceneViewManager(sceneView: sceneView)
        sceneViewManager.delegate = self
        performSegue(withIdentifier: Segue.toObjectInspection.rawValue, sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueCase = Segue(rawValue: segue.identifier)
        switch segueCase {
        case .toObjectInspection:
            objectInspectionWidget = segue.destination as? ObjectInspectionManagerProtocol
        default: return
        }
    }
    
    // MARK: - Private API
    private func configure() {
        configureGestures()
    }
    
    private func configureGestures() {
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: - Actions
    @IBAction private func closeAction(_ sender: Any) {
        output?.didCloseAction()
    }
    
    @IBAction func resetCameraPositionAction(_ sender: Any) {
        sceneViewManager.resetPointOfViewToDefaults()
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        sceneViewManager.handleTap(sender)
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

extension LayoutInspectorViewController: SceneViewManagerDelegate {
    func selectedViewMetadataDidUpdate(_ metadata: ViewMetadataProtocol?) {
        objectInspectionWidget?.renderViewMetadata(metadata)
    }
}
