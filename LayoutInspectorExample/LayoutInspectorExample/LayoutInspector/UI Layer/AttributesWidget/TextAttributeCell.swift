//
//  ObjectInspectionTextDataCell.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/2/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit

class TextAttributeCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet private weak var trailingSeparator: UIView!
    
    static func estimatedHeight(title: String, value: String?, cellWidth: CGFloat) -> CGFloat {
        let contentWidthConstraint = cellWidth - Layout.contentInsets.left - Layout.contentInsets.right
        let titleHeight = title.height(withConstrainedWidth: contentWidthConstraint, font: Styleguide.font)
        let valueHeight = value?.height(withConstrainedWidth: contentWidthConstraint, font: Styleguide.font) ?? 0
        return titleHeight + valueHeight + Layout.contentInsets.top + Layout.contentInsets.bottom
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyles()
    }
}

// MARK: - Nested types
private extension TextAttributeCell {
    enum Layout {
        static let contentInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 4)
    }
    
    enum Styleguide {
        static let font: UIFont = .appH3
    }
}

extension TextAttributeCell: Themeable {
    func configureStyles() {
        titleLabel.font = Styleguide.font
        titleLabel.textColor = .appLight
        valueLabel.font = Styleguide.font
        valueLabel.textColor = .appLight
        trailingSeparator.backgroundColor = .secondaryLightColor
    }
}
