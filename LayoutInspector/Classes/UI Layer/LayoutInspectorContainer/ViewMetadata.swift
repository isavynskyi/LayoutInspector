//
//  ViewMetadata.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/4/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit

protocol ViewMetadataProtocol {
    var className: String { get }
    var isUserInteractionEnabled: Bool { get }
    var alpha: Float { get }
    var backgroundColor: UIColor? { get }
    var tint: UIColor? { get }
    var clipToBounds: Bool { get }
    var frame: CGRect { get }
    var font: UIFont? { get }
}

struct ViewMetadata: ViewMetadataProtocol {
    var className: String
    var isUserInteractionEnabled: Bool
    var alpha: Float
    var backgroundColor: UIColor?
    var tint: UIColor?
    var clipToBounds: Bool
    var frame: CGRect
    var font: UIFont?
    
    init(with viewDescriptor: ViewDescriptionProtocol) {
        self.className = viewDescriptor.className
        self.isUserInteractionEnabled = viewDescriptor.isUserInteractionEnabled
        self.alpha = viewDescriptor.alpha
        self.backgroundColor = viewDescriptor.backgroundColor
        self.tint = viewDescriptor.tint
        self.clipToBounds = viewDescriptor.clipToBounds
        self.frame = viewDescriptor.frame
        self.font = viewDescriptor.font
    }
}
