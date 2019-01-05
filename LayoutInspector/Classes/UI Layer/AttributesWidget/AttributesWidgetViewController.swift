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
    private var attributesManager: AttributesManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attributesManager = ObjectAttributesManager(collectionView: collectionView)
    }
}

extension AttributesWidgetViewController: AttributesManagerProtocol {
    func renderViewMetadata(_ metadata: ViewMetadataProtocol?) {
        attributesManager?.renderViewMetadata(metadata)
    }
}
