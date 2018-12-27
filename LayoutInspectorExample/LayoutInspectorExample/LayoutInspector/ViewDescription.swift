//
//  ViewDescription.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewDescriptionProtocol {
    var frame: CGRect {get}
    var snapshot: UIImage {get}
    var subviews: [ViewDescriptionProtocol]? {get set}
    var parentSize: CGSize? {get}
    var center: CGPoint {get}
}

open class ViewDescription: ViewDescriptionProtocol {
    public let frame: CGRect
    public let snapshot: UIImage
    public var subviews: [ViewDescriptionProtocol]?
    public var parentSize: CGSize?
    public var center: CGPoint

    init(frame: CGRect, snapshot: UIImage, subviews: [ViewDescriptionProtocol]?, parentSize: CGSize?, center: CGPoint) {
        self.frame = frame
        self.snapshot = snapshot
        self.subviews = subviews
        self.parentSize = parentSize
        self.center = center
    }
}
