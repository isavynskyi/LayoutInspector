//
//  ColorAttributeCell.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/2/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit

class ColorAttributeCell: TextAttributeCell {
    @IBOutlet weak var colorView: UIView!

    static func calculateEstimatedHeight(title: String, value: String?, cellWidth: CGFloat) -> CGFloat {
        let contentWidthConstraint = cellWidth - Layout.contentInsets.left - Layout.contentInsets.right
        let titleHeight = title.height(withConstrainedWidth: contentWidthConstraint, font: Styleguide.font)
        let valueHeight = value?.height(withConstrainedWidth: contentWidthConstraint - Layout.valueLabelXPos, font: Styleguide.font) ?? 0
        return titleHeight + valueHeight + Layout.contentInsets.top + Layout.contentInsets.bottom
    }

    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureColorView()
    }
    
    // MARK: - Private API
    private func configureColorView() {
        colorView.layer.cornerRadius = colorView.bounds.height/2.0
        colorView.layer.borderWidth = 1.0
        colorView.layer.borderColor = UIColor.appLight.cgColor
    }
}

// MARK: - Nested types
private extension TextAttributeCell {
    struct Layout {
        static let contentInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 4)
        static let valueLabelXPos: CGFloat = 24.0
    }
    
    struct Styleguide {
        static let font: UIFont = .appH3
    }
}
