//
//  LayoutInspector.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit

public class LayoutInspector {
    var count = 0

    static let shared = LayoutInspector()
    private init() {}
    
    lazy private var presenter: LayoutInspectorPresenter = {
        return makeLayoutInspectorPresenter()
    }()
    
    var viewController: LayoutInspectorViewController?
    
    //MARK: - API
    func showLayout() {
        snapshotHierarchy()
    }
}

// MARK: - Private API
private extension LayoutInspector {
    func snapshotHierarchy() {
        let hierarchy = buildHierarchy(view: UIApplication.shared.windows.first!)
        presenter.showInspectorView()
    }
    
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
    
    func storeImage(_ image:UIImage, name: String) {
        let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        print(documentsPathURL)
        let writePath = documentsPathURL?.appendingPathComponent(name)
        try? image.pngData()?.write(to: writePath!)
    }
}

// MARK: - Presenter
private extension LayoutInspector {
    func makeLayoutInspectorPresenter() -> LayoutInspectorPresenter {
        let view = layoutInspectorPresenterView()
        viewController = view
        view.loadView()
        let presenter = LayoutInspectorPresenter()
        view.output = presenter
        presenter.view = view
        return presenter
    }
    
    func layoutInspectorPresenterView() -> LayoutInspectorViewController {
        let storyboard = UIStoryboard(name: "LayoutInspector", bundle: nil)
        let viewController: LayoutInspectorViewController = storyboard.instantiateViewController(withIdentifier: "LayoutInspectorViewController") as! LayoutInspectorViewController
        return viewController
    }
}
