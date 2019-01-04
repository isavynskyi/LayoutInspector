//
//  LayoutInspectorContainerViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/28/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit
import SceneKit

class LayoutInspectorPresenter {
    weak var view: LayoutInspectorViewInput?
    weak var delegate: LayoutInspectorPresenterDelegate?
    
    private var wrapperNode = SCNNode()
    private lazy var renderingTreeBuilder: RenderingTreeBuilderProtocol = {
       return RenderingTreeBuilder()
    }()
    
    func showInspectorView(for viewDescription: ViewDescriptionProtocol) {
        renderLayoutNodes(for: viewDescription)
        showView()
    }
}

private extension LayoutInspectorPresenter {
    func showView() {
        guard let appWindow = UIApplication.shared.keyWindow,
            let rootView = view?.rootView() else { return }
        appWindow.addSubview(rootView)
    }
    
    func renderLayoutNodes(for viewDescription: ViewDescriptionProtocol) {
        let renderingTree = renderingTreeBuilder.build(from: viewDescription)
        if let rootNode = renderingTree.viewNode {
            wrapperNode.addChildNode(rootNode)
            view?.addNodeToScene(wrapperNode)
        }
    }
}

extension LayoutInspectorPresenter: LayoutInspectorViewOutput {
    func didCloseAction() {
        view?.removeNode(wrapperNode)
        wrapperNode.childNodes.forEach { $0.removeFromParentNode() }
        let rootView = view?.rootView()
        rootView?.removeFromSuperview()
        delegate?.didFinishLayoutInspection()
    }
}
