//
//  HierarchyBuilder.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/26/18.
//  Copyright © 2018 Ihor Savynskyi. All rights reserved.
//

import UIKit

protocol HierarchyBuilder {
    func snapshotHierarchy() -> ViewDescriptorProtocol
}

class HierarchyBuilderImpl {
    private var count = 0       // TODO: - remove
}

extension HierarchyBuilderImpl: HierarchyBuilder {
    func snapshotHierarchy() -> ViewDescriptorProtocol {
        return buildHierarchy(view: UIApplication.shared.windows.first!)
    }
}

// MARK: Private API
private extension HierarchyBuilderImpl {
    // TODO: -
    func buildHierarchy(view: UIView) -> ViewDescriptorProtocol {
        let children = view.subviews.map { buildHierarchy(view: $0)}
        view.subviews.forEach {$0.isHidden = true}
        let image = view.asImage()
        view.subviews.forEach {$0.isHidden = false}
        let descriptor = ViewDescriptor(frame: view.frame, snapshot: image, subviews: children)
        
        count += 1
        storeImage(image, name: String(count))
        print( "\(count): dframe = \(view.frame.width), \(view.frame.height), \(view.frame.origin)")
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
