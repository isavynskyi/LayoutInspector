//
//  ObjectInspectionViewController.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/2/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit

class ObjectInspectionViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    private var objectInspectionManager: ObjectInspectionManagerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objectInspectionManager = ObjectInspectionManager(collectionView: collectionView)
        view.backgroundColor = .sceneBackground
    }

}

extension ObjectInspectionViewController: ObjectInspectionManagerProtocol {
    func renderViewMetadata(_ metadata: ViewMetadataProtocol?) {
        objectInspectionManager.renderViewMetadata(metadata)
    }
}
