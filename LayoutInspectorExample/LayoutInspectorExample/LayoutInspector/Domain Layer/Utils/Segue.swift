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
    case toMenuWidgetViewControler
    case toObjectAttributes
    case toSceneWidgetViewController
}

extension Segue: RawRepresentable {
    typealias RawValue = String

    init(rawValue: RawValue?) {
        switch rawValue {
        case "toMenuWidgetViewControler": self = .toMenuWidgetViewControler
        case "toObjectAttributes": self = .toObjectAttributes
        case "toSceneWidgetViewController": self = .toSceneWidgetViewController
        default: self = .unnamed
        }
    }

    var rawValue: RawValue {
        switch self {
        case .toMenuWidgetViewControler: return "toMenuWidgetViewControler"
        case .toObjectAttributes: return "toObjectAttributes"
        case .toSceneWidgetViewController: return "toSceneWidgetViewController"
        case .unnamed: return ""
        }
    }
}
