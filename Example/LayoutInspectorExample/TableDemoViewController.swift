//
//  TableDemoViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/5/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit
import LayoutInspector

class TableDemoViewController: UITableViewController {
    
    @IBAction private func inspectAction(_ sender: Any) {
        LayoutInspector.shared.showLayout()
    }
	
	@IBAction func changeAutoTrigger(_ sender: Any) {
		changeAutoTrigger()
	}
}

extension UIViewController {
	
	func changeAutoTrigger() {
		let alert = UIAlertController(title: nil, message: "select auto trigger", preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction(title: "screenshot", style: .default, handler: { (_) in
			LayoutInspector.shared.setAutoTrigger(.screenshot)
		}))
		alert.addAction(UIAlertAction(title: "shake", style: .default, handler: { (_) in
			LayoutInspector.shared.setAutoTrigger(.shake)
		}))
		alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}
}
