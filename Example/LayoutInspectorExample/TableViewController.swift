//
//  TableViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/5/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit
import LayoutInspector

class TableViewController: UITableViewController {
    
    @IBAction private func inspectAction(_ sender: Any) {
        LayoutInspector.shared.showLayout()
    }
}
