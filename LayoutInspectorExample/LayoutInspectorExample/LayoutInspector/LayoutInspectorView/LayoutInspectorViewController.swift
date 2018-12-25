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
        configureSceneView()
    }
    
    //MARK: - Actions
    @IBAction private func closeAction(_ sender: Any) {
        output?.didCloseAction()
    }
    
    private func configureSceneView() {
        sceneView.allowsCameraControl = true
    }
}

extension LayoutInspectorViewController: LayoutInspectorViewInput {
    func rootView() -> UIView {
        return view
    }
}
