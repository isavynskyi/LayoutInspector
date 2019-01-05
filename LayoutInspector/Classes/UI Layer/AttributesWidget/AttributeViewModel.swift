//
//  AttributeViewModel.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/3/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit

enum AttributeValue {
    case text(String?)
    case color(UIColor?)
}

struct AttributeViewModel {
    let title: String
    let value: AttributeValue
    
    var valueStringRepresentation: String? {
        switch value {
        case .text(let text):
            return text
        case .color(let color):
            return valueStringFor(color)
        }
    }
    
    func valueStringFor(_ color: UIColor?) -> String {
        switch color {
        case nil:
            return "<nil color>"
        case UIColor.clear:
            return "White:0\nAlpha:0"
        case let customColor?:
            return "R:\(String(format: "%.2f", customColor.redValue))\nG:\(String(format: "%.2f", customColor.greenValue))\nB:\(String(format: "%.2f", customColor.blueValue))\nA:\(String(format: "%.2f", customColor.alphaValue))"
        default:
            return "unknown color"
        }
    }
}
