//
//  ChangeAutoTriggerProtocol.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 9/29/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import Foundation
import UIKit
import LayoutInspector

protocol ChangeAutoTriggerProtocol {
    func changeAutoTrigger()
}
 
extension ChangeAutoTriggerProtocol where Self: UIViewController {
    func changeAutoTrigger() {
        let alert = UIAlertController(title: nil, message: "Select auto trigger", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Screenshot", style: .default, handler: { (_) in
            LayoutInspector.shared.setAutoTrigger(.screenshot)
        }))
        alert.addAction(UIAlertAction(title: "Shake", style: .default, handler: { (_) in
            LayoutInspector.shared.setAutoTrigger(.shake)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
