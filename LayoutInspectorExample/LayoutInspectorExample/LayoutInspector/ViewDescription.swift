//
//  ViewDescription.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import Foundation
import UIKit

protocol ViewDescriptionProtocol {
    var frame: CGRect { get }
    var snapshot: UIImage? { get }
    var subviews: [ViewDescriptionProtocol]? { get set }
    var parentSize: CGSize? { get }
    var center: CGPoint { get }
    var isHidden: Bool { get }
    var isTransparent: Bool { get }
    var className: String { get }
    var isUserInteractionEnabled: Bool { get }
    var alpha: Float { get }
    var backgroundColor: UIColor? { get }
    var tint: UIColor? { get }
    var clipToBounds: Bool { get }
}

class ViewDescription: ViewDescriptionProtocol {
    public let frame: CGRect
    public let snapshot: UIImage?
    public var subviews: [ViewDescriptionProtocol]?
    public var parentSize: CGSize?
    public var center: CGPoint
    public var isHidden: Bool
    public var isTransparent: Bool {
        return snapshot == nil
    }
    var className: String
    var isUserInteractionEnabled: Bool
    var alpha: Float
    var backgroundColor: UIColor?
    var tint: UIColor?
    var clipToBounds: Bool

    // MARK: - Init
    init(frame: CGRect,
         snapshot: UIImage?,
         subviews: [ViewDescriptionProtocol]?,
         parentSize: CGSize?,
         center: CGPoint,
         isHidden: Bool,
         className: String,
         isUserInteractionEnabled: Bool,
         alpha: Float,
         backgroundColor: UIColor?,
         tint: UIColor?,
         clipToBounds: Bool)
    {
        self.frame = frame
        self.snapshot = snapshot
        self.subviews = subviews
        self.parentSize = parentSize
        self.center = center
        self.isHidden = isHidden
        self.className = className
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.alpha = alpha
        self.backgroundColor = backgroundColor
        self.tint = tint
        self.clipToBounds = clipToBounds
    }
}
