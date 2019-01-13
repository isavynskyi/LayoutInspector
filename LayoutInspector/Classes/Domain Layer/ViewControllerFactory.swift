//
//  ViewControllerFactory.swift
//  LayoutInspector
//
//  Created by Igor Savynskyi on 1/13/19.
//

import UIKit

class ViewControllerFactory {
    
    static func createLayoutInspectorContainerViewController() -> LayoutInspectorContainerViewController {
        let storyboard = UIStoryboard(name: "LayoutInspector", bundle: Bundle.layoutInspectorBundle)
        let viewController: LayoutInspectorContainerViewController = storyboard.instantiateViewController(withIdentifier: "LayoutInspectorContainerViewController") as! LayoutInspectorContainerViewController
        return viewController
    }
}



