//
//  ColorAttributeCell.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/2/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit

class ColorAttributeCell: TextAttributeCell {
    @IBOutlet private weak var colorView: UIView!
    @IBOutlet private weak var checkeredPatternImageView: UIImageView!
    
    static func calculateEstimatedHeight(title: String, value: String?, cellWidth: CGFloat) -> CGFloat {
        let contentWidthConstraint = cellWidth - Layout.contentInsets.left - Layout.contentInsets.right
        let titleHeight = title.height(withConstrainedWidth: contentWidthConstraint, font: Styleguide.font)
        let valueHeight = value?.height(withConstrainedWidth: contentWidthConstraint - Layout.valueLabelXPos, font: Styleguide.font) ?? 0
        return titleHeight + valueHeight + Layout.contentInsets.top + Layout.contentInsets.bottom
    }
    
    func renderColorAttribute(_ color: UIColor?) {
        colorView.backgroundColor = color
        
        let colorAlpha = Float(color?.alphaValue ?? 0)
        checkeredPatternImageView.isHidden = (colorAlpha == 0.0 || colorAlpha == 1.0)
    }
    
    // MARK: - Private API
    private func configureColorView() {
        colorView.layer.cornerRadius = colorView.bounds.height/2.0
        colorView.layer.borderWidth = 1.0
        colorView.layer.borderColor = UIColor.appLight.cgColor
        
        checkeredPatternImageView.layer.cornerRadius = checkeredPatternImageView.bounds.height/2.0
        checkeredPatternImageView.layer.masksToBounds = true
    }
}

// MARK: - Nested types
private extension ColorAttributeCell {
    struct Layout {
        static let contentInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 4)
        static let valueLabelXPos: CGFloat = 24.0
    }
    
    struct Styleguide {
        static let font: UIFont = .appH3
    }
}

// MARK: - Themeable
extension ColorAttributeCell  {
    override func configureStyles() {
        super.configureStyles()
        configureColorView()
    }
}

