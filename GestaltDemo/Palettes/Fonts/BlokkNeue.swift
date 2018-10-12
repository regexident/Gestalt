//
//  BlokkNeue.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

// Font from: http://www.blokkfont.com/
enum BlokkNeueFont {
    static let fontName = "BLOKKNeue"

    enum Weight: String {
        static var `default` = Weight.regular

        case regular
    }

    private static func name(for weight: Weight) -> String {
        return "\(self.fontName)-\(weight.rawValue.capitalized)"
    }

    static func with(textStyle: UIFont.TextStyle, weight: Weight = .default) -> UIFont {
        let name = self.name(for: weight)
        let descriptor = UIFontDescriptor.preferredFontDescriptor(
            withName: name,
            textStyle: textStyle
        )
        return UIFont(descriptor: descriptor, size: descriptor.pointSize)
    }

    static func with(size: CGFloat, weight: Weight = .default) -> UIFont {
        let name = self.name(for: weight)
        guard let font = UIFont(name: name, size: size) else {
            print("Could not find font with name: '\(name)'")
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
