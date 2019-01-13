//
//  SceneWidgetViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/3/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit
import SceneKit

class SceneWidgetViewController: UIViewController {
    weak var delegate: SceneViewManagerDelegate?
    private var sceneViewManager: SceneViewManagerProtocol?
    private var tapGestureRecognizer: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    }

    @IBOutlet private weak var sceneView: SCNView!

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneViewManager = SceneViewManager(sceneView: sceneView)
        sceneViewManager?.delegate = self
        configure()
    }
}

extension SceneWidgetViewController: SceneWidgetProtocol {
    func resetPointOfViewToDefaults() {
        sceneViewManager?.resetPointOfViewToDefaults()
    }
    
    func addNode(_ node: SCNNode) {
        sceneViewManager?.addNode(node)
    }
    
    func removeNode(_ node: SCNNode) {
        sceneViewManager?.removeNode(node)
    }
}

// MARK: - Private API
private extension SceneWidgetViewController {
    func configure() {
        configureGestures()
    }
    
    func configureGestures() {
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        sceneViewManager?.handleTap(sender)
    }
}

extension SceneWidgetViewController: SceneViewManagerDelegate {
    func selectedViewMetadataDidUpdate(_ metadata: ViewMetadataProtocol?) {
        delegate?.selectedViewMetadataDidUpdate(metadata)
    }
}
