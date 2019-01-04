//
//  LayoutInspector.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit

public enum TriggerType {
    case custom
    case screenshot
}

public class LayoutInspector {
    static let shared = LayoutInspector()
    private init() {}

    private var triggerType: TriggerType = .custom
    private var viewController: LayoutInspectorContainerViewController?
    lazy private var hierarchyBuilder: HierarchyBuilder = {return HierarchyBuilderImpl()}()
    lazy private var presenter: LayoutInspectorPresenter = {return makeLayoutInspectorPresenter()}()
}

//MARK: - Public API
public extension LayoutInspector {
    @objc func showLayout() {
        #if DEBUG
        let viewDescriptionTree = hierarchyBuilder.snapshotHierarchy()
        presenter.showInspectorView(for: viewDescriptionTree)
        #endif
    }
    
    func setTriggerType(_ trigger: TriggerType) {
        triggerType = trigger
        unsubscribe()
        subscribeForCurrentTrigger()
    }
}

//MARK: - Private API
private extension LayoutInspector {
    func subscribeForCurrentTrigger() {
        switch triggerType {
        case .screenshot:
            NotificationCenter.default.addObserver(self, selector: #selector(showLayout), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        case .custom: return
        }
    }
    
    func unsubscribe() {
        switch triggerType {
        case .screenshot:
            NotificationCenter.default.removeObserver(self)
        case .custom: return
        }
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
