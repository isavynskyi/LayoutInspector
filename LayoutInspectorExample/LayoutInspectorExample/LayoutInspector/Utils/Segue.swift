//
//  Segue.swift
//  LayoutInspectorExample
//
//  Created by Igor Savynskyi on 1/2/19.
//  Copyright © 2019 Ihor Savynskyi. All rights reserved.
//

import Foundation

enum Segue: String {
    case unnamed
    case toObjectInspection
}

extension Segue: RawRepresentable {
    typealias RawValue = String

    init(rawValue: RawValue?) {
        switch rawValue {
        case "toObjectInspection": self = .toObjectInspection
        default: self = .unnamed
        }
    }

    var rawValue: RawValue {
        switch self {
        case .toObjectInspection: return "toObjectInspection"
        case .unnamed: return ""
        }
    }
}
