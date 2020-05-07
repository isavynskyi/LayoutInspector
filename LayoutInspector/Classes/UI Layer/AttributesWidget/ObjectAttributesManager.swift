//
//  ObjectAttributesManager.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/2/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit

class ObjectAttributesManager: NSObject, AttributesManagerProtocol {
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
private extension ObjectAttributesManager {
    enum LayoutConstants {
        static let collectionItemWidth: CGFloat = 82.0
    }
}

extension ObjectAttributesManager: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sourceItem = dataSource[indexPath.row]
        
        switch sourceItem.value {
        case .text(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextAttributeCell.reuseIdentifier, for: indexPath) as! TextAttributeCell
            cell.titleLabel.text = sourceItem.title
            cell.valueLabel.text = sourceItem.valueStringRepresentation
            return cell
        case .color(let colorValue):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorAttributeCell.reuseIdentifier, for: indexPath) as! ColorAttributeCell
            cell.titleLabel.text = sourceItem.title
            cell.renderColorAttribute(colorValue)
            cell.valueLabel.text = sourceItem.valueStringRepresentation
            return cell
        }
    }
    
}

extension ObjectAttributesManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sourceItem = dataSource[indexPath.row]
        let height: CGFloat
        switch sourceItem.value {
        case .text(_):
            height = TextAttributeCell.estimatedHeight(title: sourceItem.title,
                                                       value: sourceItem.valueStringRepresentation,
                                                       cellWidth: LayoutConstants.collectionItemWidth)
        case .color(_):
            height = ColorAttributeCell.calculateEstimatedHeight(title: sourceItem.title,
                                                                 value: sourceItem.valueStringRepresentation,
                                                                 cellWidth: LayoutConstants.collectionItemWidth)
        }
        return CGSize(width: LayoutConstants.collectionItemWidth, height: height)
    }
}

// MARK: - Private API
private extension ObjectAttributesManager {
    func generateDataSource(from metadata: ViewMetadataProtocol?) -> [AttributeViewModel] {
        guard let metadata = metadata else { return [] }
        
        let userInteractionValue = metadata.isUserInteractionEnabled ? "On" : "Off"
        let clipToBoundsValue = metadata.clipToBounds ? "On" : "Off"
        
        var attributes = [AttributeViewModel(title: "Class Name", value: .text(metadata.className)),
                          AttributeViewModel(title: "User Interaction Enabled", value: .text(userInteractionValue)),
                          AttributeViewModel(title: "Alpha", value: .text(String(describing: metadata.alpha))),
                          AttributeViewModel(title: "Background Color", value: .color(metadata.backgroundColor)),
                          AttributeViewModel(title: "Tint", value: .color(metadata.tint)),
                          AttributeViewModel(title: "Clip To Bounds", value: .text(clipToBoundsValue)),
                          AttributeViewModel(title: "Frame", value: .text(String(describing: metadata.frame)))]
        if metadata.font != nil {
            attributes.append(AttributeViewModel(title: "Font", value: .text(String(describing: metadata.font!.attributeDescription))))
        }
        
        return attributes
    }
}

