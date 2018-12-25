//
//  UIView+Extension.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

// TODO: - remove
extension UIView {
    /**
     Wrapper for useful debugging description of view hierarchy
     */
    var recursiveDescription: NSString {
        return value(forKey: "recursiveDescription") as! NSString
    }
}
