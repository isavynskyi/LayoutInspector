//
//  ControlsDemoViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit
import LayoutInspector

class ControlsDemoViewController: UIViewController, ChangeAutoTriggerProtocol {

    @IBAction private func inspectLayoutAction(_ sender: Any) {
        LayoutInspector.shared.showLayout()
    }
	@IBAction func changeAutoTrigger(_ sender: Any) {
		changeAutoTrigger()
	}
}

