//
//  HierarchyBuilder.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/26/18.
//  Copyright © 2018 Ihor Savynskyi. All rights reserved.
//

import UIKit

protocol HierarchyBuilderProtocol {
    func captureHierarchy() -> ViewDescriptionProtocol?
}

class HierarchyBuilder: HierarchyBuilderProtocol {
    func captureHierarchy() -> ViewDescriptionProtocol? {
        guard let firstWindow = UIApplication.shared.windows.first else { return nil }
        return buildHierarchy(view: firstWindow)
    }
}

// MARK: Private API
private extension HierarchyBuilder {
    func buildHierarchy(view: UIView) -> ViewDescriptionProtocol {
        let children = view.subviews.map { buildHierarchy(view: $0) }
        let viewsToHide = view.subviews.filter { $0.isHidden == false }
        
        // don't capture visible subviews for current view snapshot
        viewsToHide.forEach { $0.isHidden = true }
        let isTransparent = isViewTransparent(view)
        let image = isTransparent ? nil : view.asImage()
        // hidden subviews rollback
        viewsToHide.forEach { $0.isHidden = false }
        
        return ViewDescription(frame: view.frame,
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
                               clipToBounds: view.clipsToBounds,
                               font: view.visibleFont)
    }
    
    func isViewTransparent(_ view: UIView) -> Bool {
        let isTransparent: Bool
        if view.isKind(of: UIImageView.self) || view.isKind(of: UILabel.self) || view.isKind(of: UITextView.self) {
            isTransparent = false
        } else if view.backgroundColor == .clear || view.alpha == 0 || view.backgroundColor?.alphaValue == 0 || view.backgroundColor == nil {
            isTransparent = true
        } else {
            isTransparent = false
        }
        return isTransparent
    }
}
