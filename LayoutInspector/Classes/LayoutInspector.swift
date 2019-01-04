//
//  LayoutInspector.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 12/25/18.
//  Copyright © 2018 Igor Savynskyi. All rights reserved.
//

import UIKit

/// Type of trigger used to fire layout inspection
public enum TriggerType {
    /// Fire manually by calling func LayoutInspector.shared.showLayout()
    case custom
    
    /// Fire automatically whenever screenshot is taken
    case screenshot
}

/**
 The `LayoutInspector` is designed to be single communication point for the entire LayoutInspector module
 
 - Important:
 Layout inspection shown only in DEBUG build configuration
*/
public final class LayoutInspector: NSObject {
    /// Returns the singleton instance of an `LayoutInspector`.
    public static let shared = LayoutInspector()
    private override init() {}

    private var triggerType: TriggerType = .custom
    private var viewController: LayoutInspectorContainerViewController?
    private var hierarchyBuilder: HierarchyBuilderProtocol = HierarchyBuilder()
    private var presenter: LayoutInspectorPresenter?
}

//MARK: - Public API
public extension LayoutInspector {
    /**
     Call this start layout debugging
     - Important:
     Layout inspection shown only in DEBUG build configuration
     */
    @objc func showLayout() {
        #if DEBUG
        guard let viewDescriptionTree = hierarchyBuilder.captureHierarchy() else { return }
        presenter = makeLayoutInspectorPresenter()
        presenter?.showInspectorView(for: viewDescriptionTree)
        #endif
    }
    
    /**
     Call this function to specify preffered layout inspection trigger type
     - parameter trigger: The desired trigger type enum case
     */
    func setTriggerType(_ trigger: TriggerType) {
        unsubscribe()
        triggerType = trigger
        subscribeForCurrentTrigger()
    }
}

//MARK: - Private API
private extension LayoutInspector {
    func subscribeForCurrentTrigger() {
        switch triggerType {
        case .screenshot:
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(showLayout),
                                                   name: UIApplication.userDidTakeScreenshotNotification,
                                                   object: nil)
        case .custom: return
        }
    }
    
    func unsubscribe() {
        switch triggerType {
        case .screenshot:
            NotificationCenter.default.removeObserver(self,
                                                      name: UIApplication.userDidTakeScreenshotNotification,
                                                      object: nil)
        case .custom: return
        }
    }
}


// MARK: - Container Module Configuration
private extension LayoutInspector {
    func makeLayoutInspectorPresenter() -> LayoutInspectorPresenter {
        let view = makeLayoutInspectorContainerView()
        viewController = view
        view.loadView()
        view.viewDidLoad()
        
        let presenter = LayoutInspectorPresenter()
        view.output = presenter
        presenter.view = view
        presenter.delegate = self
        return presenter
    }
    
    func makeLayoutInspectorContainerView() -> LayoutInspectorContainerViewController {
        let storyboard = UIStoryboard(name: "LayoutInspector", bundle: Bundle.layoutInspectorBundle)
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
