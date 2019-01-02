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
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyles()
    }
}

extension TextAttributeCell: Themeable {
    func configureStyles() {
        titleLabel.font = .appH5
        titleLabel.textColor = .appLight
        valueLabel.font = .appH5
        valueLabel.textColor = .appLight
        trailingSeparator.backgroundColor = .appLight
    }
}

extension TextAttributeCell: SeparatorPresentable {
    func showTrailingSeparator(show: Bool) {
        trailingSeparator.isHidden = !show
    }
}
