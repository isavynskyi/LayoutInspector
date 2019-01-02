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
