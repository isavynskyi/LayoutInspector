//
//  TableDemoViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/5/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit
import LayoutInspector

class TableDemoViewController: UITableViewController, ChangeAutoTriggerProtocol {
    
    @IBAction private func inspectAction(_ sender: Any) {
        LayoutInspector.shared.showLayout()
    }
	
	@IBAction func changeAutoTrigger(_ sender: Any) {
		changeAutoTrigger()
	}
}
