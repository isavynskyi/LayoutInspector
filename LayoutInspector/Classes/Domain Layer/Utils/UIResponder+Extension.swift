//
//  UIResponder+Extension.swift
//  LayoutInspector
//
//  Created by mikun on 2019/9/25.
//  
//

import UIKit


extension UIResponder {
	static var motionEnded_ShakeIMP: IMP?
	@objc func motionEnded_Shake(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
		if self.responds(to: #selector(motionEnded_Shake(_:with:))) {
			self.motionEnded_Shake(motion, with: event)
		}
		
		if motion == .motionShake {
			LayoutInspector.shared.showLayout()
		}
	}
}
