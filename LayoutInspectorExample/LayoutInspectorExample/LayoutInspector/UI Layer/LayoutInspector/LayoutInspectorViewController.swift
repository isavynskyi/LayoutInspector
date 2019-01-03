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
    private var sceneWidget: SceneWidgetProtocol?
    private var objectInspectionWidget: AttributesManagerProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWidgets()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueCase = Segue(rawValue: segue.identifier)
        switch segueCase {
        case .toObjectAttributes:
            objectInspectionWidget = segue.destination as? AttributesManagerProtocol
        case .toSceneWidgetViewController:
            sceneWidget = segue.destination as? SceneWidgetProtocol
            sceneWidget?.delegate = self
        case .unnamed:
            return
        }
    }
    
    // MARK: - Private API
    private func loadWidgets() {
        performSegue(withIdentifier: Segue.toObjectAttributes.rawValue, sender: self)
        performSegue(withIdentifier: Segue.toSceneWidgetViewController.rawValue, sender: self)
    }

    //MARK: - Actions
    @IBAction private func closeAction(_ sender: Any) {
        output?.didCloseAction()
    }
    
    @IBAction func resetCameraPositionAction(_ sender: Any) {
        sceneWidget?.resetPointOfViewToDefaults()
    }
}

extension LayoutInspectorViewController: LayoutInspectorViewInput {
    func rootView() -> UIView {
        return view
    }
    
    func addNodeToScene(_ node: SCNNode) {
        sceneWidget?.addNodeToScene(node)
    }
    
    func removeNode(_ node: SCNNode) {
        sceneWidget?.removeNode(node)
    }
}

extension LayoutInspectorViewController: SceneViewManagerDelegate {
    func selectedViewMetadataDidUpdate(_ metadata: ViewMetadataProtocol?) {
        objectInspectionWidget?.renderViewMetadata(metadata)
    }
}
