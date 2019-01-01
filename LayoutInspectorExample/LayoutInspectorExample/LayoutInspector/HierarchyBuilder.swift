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

class HierarchyBuilderImpl {
    private var count = 0       // TODO: - remove
}

extension HierarchyBuilderImpl: HierarchyBuilder {
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
        let isTransparent = view.backgroundColor == .clear
        let image = isTransparent ? nil : view.asImage()

        // hidden subviews rollback
        temporaryHiddenViews.forEach {$0.isHidden = false}
        
        String(describing: view)
        
        class_getSuperclass(view.superclass)
        let descriptor = ViewDescription(frame: view.frame,
                                         snapshot: image,
                                         subviews: children,
                                         parentSize: view.superview?.frame.size,
                                         center: view.center,
                                         isHidden: view.isHidden,
                                         className: String(describing: type(of: view)),
                                         isUserInteractionEnabled: view.isUserInteractionEnabled,
                                         alpha: Float(view.alpha),
                                         backgroundColor: view.backgroundColor,
                                         tint: view.tintColor,
                                         clipToBounds: view.clipsToBounds)
        
        // TODO: - remove if needed
        count += 1
        if let image = image {
            storeImage(image, name: String(count))
            print( "\(count): dframe = \(view.frame.width), \(view.frame.height), \(view.frame.origin)")
        }
        return descriptor
    }
    
    // MARK: - Private API
    func storeImage(_ image:UIImage, name: String) {
        let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        print(documentsPathURL)
        let writePath = documentsPathURL?.appendingPathComponent(name)
        try? image.pngData()?.write(to: writePath!)
    }
}
