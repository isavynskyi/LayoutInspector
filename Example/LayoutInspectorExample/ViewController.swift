//
//  ViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - Private API
    private func takeSnapshot() {
        LayoutInspector.shared.showLayout()
    }
    
    //MARK: Actions
    @IBAction private func inspectLayoutAction(_ sender: Any) {
        takeSnapshot()
    }
}

