//
//  ViewDescriptor.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewDescriptorProtocol {
    var frame: CGRect {get}
    var snapshot: UIImage {get}
    var subviews: [ViewDescriptorProtocol]? {get set}
}

open class ViewDescriptor: ViewDescriptorProtocol {
    open var subviews: [ViewDescriptorProtocol]?
    
    public let frame: CGRect
    public let snapshot: UIImage
    
    init(frame: CGRect, snapshot: UIImage, subviews: [ViewDescriptorProtocol]?) {
        self.frame = frame
        self.snapshot = snapshot
        self.subviews = subviews
    }
}
