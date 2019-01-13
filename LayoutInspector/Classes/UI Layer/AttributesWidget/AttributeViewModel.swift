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

enum ColorRepresentationPattern {
    static let nilColor = "<nil color>"
    static let clear = "White:0\nAlpha:0"
    static let regularColorFormat = "R:%.2f\nG:%.2f\nB:%.2f\nA:%.2f"
    static let unknown = "unknown color"
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
            return ColorRepresentationPattern.nilColor
        case UIColor.clear:
            return ColorRepresentationPattern.clear
        case let customColor?:
            return String(format: ColorRepresentationPattern.regularColorFormat,
                          customColor.redValue,
                          customColor.greenValue,
                          customColor.blueValue,
                          customColor.alphaValue)
        default:
            return ColorRepresentationPattern.unknown
        }
    }
}
