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

public class LayoutInspector: NSObject {
    static let shared = LayoutInspector()
    private override init() {}

    private var triggerType: TriggerType = .custom
    private var viewController: LayoutInspectorContainerViewController?
    lazy private var hierarchyBuilder: HierarchyBuilder = {return HierarchyBuilderImpl()}()
    private var presenter: LayoutInspectorPresenter?
}

//MARK: - Public API
public extension LayoutInspector {
    @objc func showLayout() {
        #if DEBUG
        let viewDescriptionTree = hierarchyBuilder.snapshotHierarchy()
        presenter = makeLayoutInspectorPresenter()
        presenter?.showInspectorView(for: viewDescriptionTree)
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
        let view = makeLayoutInspectorContainerView()
        viewController = view
        
        // TODO: - fix, trigger
        view.loadView()
        view.viewDidLoad()
        
        let presenter = LayoutInspectorPresenter()
        view.output = presenter
        presenter.view = view
        presenter.delegate = self
        return presenter
    }
    
    func makeLayoutInspectorContainerView() -> LayoutInspectorContainerViewController {
        let storyboard = UIStoryboard(name: "LayoutInspector", bundle: nil)
        let viewController: LayoutInspectorContainerViewController = storyboard.instantiateViewController(withIdentifier: "LayoutInspectorContainerViewController") as! LayoutInspectorContainerViewController
        return viewController
    }
}

extension LayoutInspector: LayoutInspectorPresenterDelegate {
    func didFinishLayoutInspection() {
        viewController = nil
        presenter = nil
    }
}
