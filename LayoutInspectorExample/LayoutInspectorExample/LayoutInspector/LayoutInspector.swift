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
    
    private var viewController: LayoutInspectorContainerViewController?
    lazy private var hierarchyBuilder: HierarchyBuilder = {return HierarchyBuilderImpl()}()
    lazy private var presenter: LayoutInspectorPresenter = {return makeLayoutInspectorPresenter()}()
    
    //MARK: - API
    func showLayout() {
        let viewDescriptionTree = hierarchyBuilder.snapshotHierarchy()
        presenter.showInspectorView(for: viewDescriptionTree)
    }
    
}



// MARK: - Presenter
private extension LayoutInspector {
    func makeLayoutInspectorPresenter() -> LayoutInspectorPresenter {
        let view = layoutInspectorPresenterView()
        viewController = view
        
        // TODO: - fix, trigger
        view.loadView()
        view.viewDidLoad()
        
        let presenter = LayoutInspectorPresenter()
        view.output = presenter
        presenter.view = view
        return presenter
    }
    
    func layoutInspectorPresenterView() -> LayoutInspectorContainerViewController {
        let storyboard = UIStoryboard(name: "LayoutInspector", bundle: nil)
        let viewController: LayoutInspectorContainerViewController = storyboard.instantiateViewController(withIdentifier: "LayoutInspectorContainerViewController") as! LayoutInspectorContainerViewController
        return viewController
    }
    
}
