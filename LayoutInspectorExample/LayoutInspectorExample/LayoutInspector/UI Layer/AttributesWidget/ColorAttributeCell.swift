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

    static func calculateEstimatedWidth(title: String, value: String?) -> CGFloat {
        let titleWidth = title.width(withConstrainedHeight: Styleguide.font.lineHeight, font: Styleguide.font)
        let valueWidth = value?.width(withConstrainedHeight: Styleguide.font.lineHeight, font: Styleguide.font) ?? 0
        return max(titleWidth, valueWidth + CGFloat(Layout.valueLabelXPos)) + CGFloat(Layout.contentLeftPadding) + CGFloat(Layout.contentRightPadding)
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
        static let contentLeftPadding = 4.0
        static let contentRightPadding = 4.0
        static let valueLabelXPos = 24.0
    }
    
    struct Styleguide {
        static let font: UIFont = .appH5
    }
}
