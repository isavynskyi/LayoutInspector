//
//  HierarchyBuilder.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/26/18.
//  Copyright © 2018 Ihor Savynskyi. All rights reserved.
//

import UIKit

protocol HierarchyBuilder {
    func snapshotHierarchy() -> ViewDescriptionProtocol
}

class HierarchyBuilderImpl: HierarchyBuilder {
    func snapshotHierarchy() -> ViewDescriptionProtocol {
        return buildHierarchy(view: UIApplication.shared.windows.first!)
    }
}

// MARK: Private API
private extension HierarchyBuilderImpl {
    // TODO: -
    func buildHierarchy(view: UIView) -> ViewDescriptionProtocol {
        let children = view.subviews.map { buildHierarchy(view: $0)}
        let temporaryHiddenViews = view.subviews.filter {$0.isHidden == false}
        
        // don't capture visible subviews for current view snapshot
        temporaryHiddenViews.forEach { $0.isHidden = true }
        let isTransparent: Bool
        if view.isKind(of: UIImageView.self) || view.isKind(of: UILabel.self) || view.isKind(of: UITextView.self) {
            isTransparent = false
        } else if view.backgroundColor == .clear || view.alpha == 0 || view.backgroundColor?.alphaValue == 0 || view.backgroundColor == nil {
            isTransparent = true
        } else {
            isTransparent = false
        }
        
        let image = isTransparent ? nil : view.asImage()
        
        // hidden subviews rollback
        temporaryHiddenViews.forEach {$0.isHidden = false}
        
        let descriptor = ViewDescription(frame: view.frame,
                                         snapshot: image,
                                         subviews: children,
                                         parentSize: view.superview?.frame.size,
                                         center: view.center,
                                         isHidden: view.isHidden,
                                         isTransparent: isTransparent,
                                         className: String(describing: type(of: view)),
                                         isUserInteractionEnabled: view.isUserInteractionEnabled,
                                         alpha: Float(view.alpha),
                                         backgroundColor: view.backgroundColor,
                                         tint: view.tintColor,
                                         clipToBounds: view.clipsToBounds)
        return descriptor
    }
}