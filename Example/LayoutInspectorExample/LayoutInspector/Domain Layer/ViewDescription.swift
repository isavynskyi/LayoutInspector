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
    var snapshotImage: UIImage? { get }
    var subviews: [ViewDescriptionProtocol]? { get }
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
    let frame: CGRect
    let snapshotImage: UIImage?
    let subviews: [ViewDescriptionProtocol]?
    let parentSize: CGSize?
    let center: CGPoint
    let isHidden: Bool
    let isTransparent: Bool
    let className: String
    let isUserInteractionEnabled: Bool
    let alpha: Float
    let backgroundColor: UIColor?
    let tint: UIColor?
    let clipToBounds: Bool

    // MARK: - Init
    init(frame: CGRect,
         snapshot: UIImage?,
         subviews: [ViewDescriptionProtocol]?,
         parentSize: CGSize?,
         center: CGPoint,
         isHidden: Bool,
         isTransparent: Bool,
         className: String,
         isUserInteractionEnabled: Bool,
         alpha: Float,
         backgroundColor: UIColor?,
         tint: UIColor?,
         clipToBounds: Bool)
    {
        self.frame = frame
        self.snapshotImage = snapshot
        self.subviews = subviews
        self.parentSize = parentSize
        self.center = center
        self.isHidden = isHidden
        self.isTransparent = isTransparent
        self.className = className
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.alpha = alpha
        self.backgroundColor = backgroundColor
        self.tint = tint
        self.clipToBounds = clipToBounds
    }
}
