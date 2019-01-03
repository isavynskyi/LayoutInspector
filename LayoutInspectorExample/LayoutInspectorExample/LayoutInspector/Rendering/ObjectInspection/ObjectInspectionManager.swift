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
    private var dataSource = [AttributeViewModel<Any>]() {
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
    struct AttributeViewModel<ValueType> {
        let title: String
        let value: ValueType
        
        var valueStringRepresentation: String? {
            switch value {
            case let text as String:
                return text
            case let color as UIColor:
                return "R:\(String(format: "%.2f", color.redValue)) G:\(String(format: "%.2f", color.greenValue)) B:\(String(format: "%.2f", color.blueValue)) A:\(String(format: "%.2f", color.alphaValue))"
            default:
                return nil
            }
        }
    }
    
    struct LayoutConstants {
        static let collectionItemHeight: CGFloat = 44.0
        static let collectionItemDefaultWidth: CGFloat = 100.0
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
        case _ as String:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextAttributeCell.reuseIdentifier, for: indexPath) as! TextAttributeCell
            configureCell(cell, item: sourceItem, isLastItem: isLastItem)
            return cell
        case _ as UIColor:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorAttributeCell.reuseIdentifier, for: indexPath) as! ColorAttributeCell
            configureCell(cell, item: sourceItem, isLastItem: isLastItem)
            return cell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: TextAttributeCell.reuseIdentifier, for: indexPath) as! TextAttributeCell
        }
    }
    
}

extension ObjectInspectionManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sourceItem = dataSource[indexPath.row]
        let width: CGFloat
        switch sourceItem.value {
        case _ as String:
            width = TextAttributeCell.estimatedWidth(title: sourceItem.title, value: sourceItem.valueStringRepresentation)
        case _ as UIColor:
            width = ColorAttributeCell.calculateEstimatedWidth(title: sourceItem.title, value: sourceItem.valueStringRepresentation)
        default:
            width = LayoutConstants.collectionItemDefaultWidth
        }
        return CGSize(width: width, height: LayoutConstants.collectionItemHeight)
    }
}

// MARK: - Private API
private extension ObjectInspectionManager {
    func generateDataSource(from metadata: ViewMetadataProtocol?) -> [AttributeViewModel<Any>] {
        guard let metadata = metadata else { return [] }
        
        let userInteractionValue = metadata.isUserInteractionEnabled ? "On" : "Off"
        let clipToBoundsValue = metadata.clipToBounds ? "On" : "Off"
        
        return [AttributeViewModel(title: "Class Name", value: metadata.className),
                AttributeViewModel(title: "User Interaction Enabled", value: userInteractionValue),
                AttributeViewModel(title: "Alpha", value: String(describing: metadata.alpha)),
                AttributeViewModel(title: "Background Color", value: metadata.backgroundColor ?? .clear),
                AttributeViewModel(title: "Tint", value: metadata.tint ?? .clear),
                AttributeViewModel(title: "Clip To Bounds", value: clipToBoundsValue),
                AttributeViewModel(title: "Frame", value: String(describing: metadata.frame))]
    }
    
    func configureCell(_ cell: TextAttributeCell, item: AttributeViewModel<Any>, isLastItem: Bool) {
        cell.titleLabel.text = item.title
        cell.valueLabel.text = item.valueStringRepresentation
        cell.showTrailingSeparator(show: !isLastItem)
    }
    
    func configureCell(_ cell: ColorAttributeCell, item: AttributeViewModel<Any>, isLastItem: Bool) {
        cell.titleLabel.text = item.title
        cell.colorView.backgroundColor = item.value as? UIColor
        cell.valueLabel.text = item.valueStringRepresentation
        cell.showTrailingSeparator(show: !isLastItem)
    }
}

