//
//  MenuWidgetViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/3/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit

class MenuWidgetViewController: UIViewController, MenuWidgetProtocol {
    weak var delegate: MenuWidgetDelegate?
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var resetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyles()
    }
    
    // MARK: - Actions
    @IBAction private func closeAction(_ sender: Any) {
        delegate?.didCloseAction()
    }
    
    @IBAction private func resetCameraPositionAction(_ sender: Any) {
        delegate?.didResetCameraPositionAction()
    }
}

extension MenuWidgetViewController: Themeable {
    func configureStyles() {
        view.backgroundColor = .sceneBackground
        closeButton.tintColor = .appLight
        resetButton.tintColor = .appLight
    }
}
    

