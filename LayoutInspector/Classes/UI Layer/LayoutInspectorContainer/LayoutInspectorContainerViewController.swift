//
//  LayoutInspectorContainerViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit
import SceneKit

class LayoutInspectorContainerViewController: UIViewController {
    // Props
    var output: LayoutInspectorViewOutput?
    private var menuWidget: MenuWidgetProtocol?
    private var sceneWidget: SceneWidgetProtocol?
    private var objectInspectionWidget: AttributesManagerProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWidgets()
        configureStyles()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier, let segueCase = Segue(rawValue: identifier) else { return }
        
        switch segueCase {
        case .toMenuWidgetViewControler:
            menuWidget = segue.destination as? MenuWidgetProtocol
            menuWidget?.delegate = self
        case .toAttributesWidgetViewController:
            objectInspectionWidget = segue.destination as? AttributesManagerProtocol
        case .toSceneWidgetViewController:
            sceneWidget = segue.destination as? SceneWidgetProtocol
            sceneWidget?.delegate = self
        }
    }
    
    // MARK: - Private API
    private func loadWidgets() {
        performSegue(withIdentifier: Segue.toMenuWidgetViewControler.rawValue, sender: self)
        performSegue(withIdentifier: Segue.toAttributesWidgetViewController.rawValue, sender: self)
        performSegue(withIdentifier: Segue.toSceneWidgetViewController.rawValue, sender: self)
    }
}

extension LayoutInspectorContainerViewController: LayoutInspectorViewInput {
    func rootView() -> UIView {
        return view
    }
    
    func addNode(_ node: SCNNode) {
        sceneWidget?.addNode(node)
    }
    
    func removeNode(_ node: SCNNode) {
        sceneWidget?.removeNode(node)
    }
}

extension LayoutInspectorContainerViewController: SceneViewManagerDelegate {
    func selectedViewMetadataDidUpdate(_ metadata: ViewMetadataProtocol?) {
        objectInspectionWidget?.renderViewMetadata(metadata)
    }
}

extension LayoutInspectorContainerViewController: MenuWidgetDelegate {
    func didCloseAction() {
        output?.didCloseAction()
    }
    
    func didResetCameraPositionAction() {
        sceneWidget?.resetPointOfViewToDefaults()
    }
}

extension LayoutInspectorContainerViewController: Themeable {
    func configureStyles() {
        view.backgroundColor = .sceneBackground
    }
}

