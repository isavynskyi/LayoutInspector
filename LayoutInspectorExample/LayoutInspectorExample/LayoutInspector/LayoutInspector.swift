//
//  LayoutInspector.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit

public class LayoutInspector {
    static let shared = LayoutInspector()
    private init() {}
    
    private var viewController: LayoutInspectorViewController?
    lazy private var hierarchyBuilder: HierarchyBuilder = {return HierarchyBuilderImpl()}()
    lazy private var presenter: LayoutInspectorPresenter = {return makeLayoutInspectorPresenter()}()
    
    //MARK: - API
    func showLayout() {
        _ = hierarchyBuilder.snapshotHierarchy()
        presenter.showInspectorView()
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
