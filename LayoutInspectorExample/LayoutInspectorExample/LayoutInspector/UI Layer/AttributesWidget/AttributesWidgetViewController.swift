//
//  AttributesWidgetViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/2/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit

class AttributesWidgetViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var objectInspectionManager: AttributesManagerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objectInspectionManager = ObjectAttributesManager(collectionView: collectionView)
        view.backgroundColor = .sceneBackground
    }

}

extension AttributesWidgetViewController: AttributesManagerProtocol {
    func renderViewMetadata(_ metadata: ViewMetadataProtocol?) {
        objectInspectionManager.renderViewMetadata(metadata)
    }
}
