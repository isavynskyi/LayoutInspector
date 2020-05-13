//
//  UIView+Extension.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    var visibleFont: UIFont? {
        if let textView = self as? UITextView {
            return textView.font
        } else if let label = self as? UILabel {
            return label.font
        } else if let button = self as? UIButton {
            return button.titleLabel?.font
        } else if let textField = self as? UITextField {
            return textField.font
        }
        
        return nil
    }
}

