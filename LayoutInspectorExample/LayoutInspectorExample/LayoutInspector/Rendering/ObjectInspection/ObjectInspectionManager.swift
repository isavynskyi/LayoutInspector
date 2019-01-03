//
//  ObjectInspectionWidget.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/2/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit

class ObjectInspectionManager: NSObject, ObjectInspectionManagerProtocol {
    private var collectionView: UICollectionView
    private var currentItem: ViewMetadataProtocol? {
        didSet { dataSource = generateDataSource(from: currentItem) }
    }
    private var dataSource = [AttributeViewModel]() {
        didSet { collectionView.reloadData() }
    }
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func renderViewMetadata(_ metadata: ViewMetadataProtocol?) {
        currentItem = metadata
    }
}

// MARK: - Nested types
private extension ObjectInspectionManager {
    struct LayoutConstants {
        static let collectionItemHeight: CGFloat = 44.0
    }
}

extension ObjectInspectionManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sourceItem = dataSource[indexPath.row]
        let isLastItem = indexPath.item == dataSource.count - 1
        
        switch sourceItem.value {
        case .text(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextAttributeCell.reuseIdentifier, for: indexPath) as! TextAttributeCell
            cell.titleLabel.text = sourceItem.title
            cell.valueLabel.text = sourceItem.valueStringRepresentation
            cell.showTrailingSeparator(show: !isLastItem)
            return cell
        case .color(let colorValue):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorAttributeCell.reuseIdentifier, for: indexPath) as! ColorAttributeCell
            cell.titleLabel.text = sourceItem.title
            cell.colorView.backgroundColor = colorValue
            cell.valueLabel.text = sourceItem.valueStringRepresentation
            cell.showTrailingSeparator(show: !isLastItem)
            return cell
        }
    }
    
}

extension ObjectInspectionManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sourceItem = dataSource[indexPath.row]
        let width: CGFloat
        switch sourceItem.value {
        case .text(_):
            width = TextAttributeCell.estimatedWidth(title: sourceItem.title, value: sourceItem.valueStringRepresentation)
        case .color(_):
            width = ColorAttributeCell.calculateEstimatedWidth(title: sourceItem.title, value: sourceItem.valueStringRepresentation)
        }
        return CGSize(width: width, height: LayoutConstants.collectionItemHeight)
    }
}

// MARK: - Private API
private extension ObjectInspectionManager {
    func generateDataSource(from metadata: ViewMetadataProtocol?) -> [AttributeViewModel] {
        guard let metadata = metadata else { return [] }
        
        let userInteractionValue = metadata.isUserInteractionEnabled ? "On" : "Off"
        let clipToBoundsValue = metadata.clipToBounds ? "On" : "Off"
        
        return [AttributeViewModel(title: "Class Name", value: .text(metadata.className)),
                AttributeViewModel(title: "User Interaction Enabled", value: .text(userInteractionValue)),
                AttributeViewModel(title: "Alpha", value: .text(String(describing: metadata.alpha))),
                AttributeViewModel(title: "Background Color", value: .color(metadata.backgroundColor)),
                AttributeViewModel(title: "Tint", value: .color(metadata.tint)),
                AttributeViewModel(title: "Clip To Bounds", value: .text(clipToBoundsValue)),
                AttributeViewModel(title: "Frame", value: .text(String(describing: metadata.frame)))]
    }
}

