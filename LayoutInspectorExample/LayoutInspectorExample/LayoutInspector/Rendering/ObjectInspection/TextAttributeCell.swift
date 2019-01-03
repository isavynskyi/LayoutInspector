//
//  ObjectInspectionTextDataCell.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/2/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import UIKit

protocol SeparatorPresentable {
    func showTrailingSeparator(show: Bool)
}

class TextAttributeCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet private weak var trailingSeparator: UIView!
    
    static func estimatedWidth(title: String, value: String?) -> CGFloat {
        let titleWidth = title.width(withConstrainedHeight: Styleguide.font.lineHeight, font: Styleguide.font)
        let valueWidth = value?.width(withConstrainedHeight: Styleguide.font.lineHeight, font: Styleguide.font)
        return max(titleWidth, valueWidth ?? 0) + CGFloat(Layout.contentLeftPadding) + CGFloat(Layout.contentRightPadding)
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyles()
    }
}

// MARK: - Nested types
private extension TextAttributeCell {
    struct Layout {
        static let contentLeftPadding = 4.0
        static let contentRightPadding = 4.0
    }
    
    struct Styleguide {
        static let font: UIFont = .appH5
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

extension TextAttributeCell: SeparatorPresentable {
    func showTrailingSeparator(show: Bool) {
        trailingSeparator.isHidden = !show
    }
}


