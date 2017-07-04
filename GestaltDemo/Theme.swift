//
//  Theme.swift
//  Gestalt
//
//  Created by Vincent Esche on 7/3/17.
//  Copyright © 2017 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

fileprivate struct FontPalette {
    static var title1: UIFont {
        return UIFont.preferredFont(forTextStyle: .title1)
    }

    static var body: UIFont {
        return UIFont.preferredFont(forTextStyle: .body)
    }
}

fileprivate struct ColorPalette {
    static let blue = UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1)
    static let yellow = UIColor(hue:0.129, saturation:0.702, brightness:0.992, alpha:1)

    static let darkGray = UIColor(hue: 0.635, saturation: 0.101, brightness: 0.2, alpha: 1)
    static let gray = UIColor(hue: 0.121, saturation: 0.101, brightness: 0.5, alpha: 1)
    static let lightGray = UIColor(hue:0.121, saturation:0.144, brightness:0.793, alpha:1)

    static let nearWhite = UIColor(hue:0.121, saturation:0.1, brightness:0.95, alpha:1)
    static let nearBlack = UIColor(hue:0.635, saturation:0.1, brightness:0.1, alpha:1)
}

struct ThemeFonts {
    var title: UIFont {
        return FontPalette.title1
    }

    var label: UIFont {
        return FontPalette.body
    }

    var textfield: UIFont {
        return FontPalette.body
    }
}

struct ThemeColors {
    let label: ThemeLabelColors
    let textfield: ThemeTextfieldColors
    let tint: UIColor
    let title: UIColor
    let background: UIColor
}

struct ThemeLabelColors {
    let text: UIColor
}

struct ThemeTextfieldColors {
    let text: UIColor
    let background: UIColor
    let borderStyle: UITextBorderStyle = .roundedRect
}

struct Theme: ThemeProtocol {
    let font: ThemeFonts
    let color: ThemeColors

    let barStyle: UIBarStyle
    let lightOpacity: Float
    let shadowOpacity: Float

    static let light: Theme = .init(
        font: ThemeFonts(),
        color: ThemeColors(
            label: ThemeLabelColors(
                text: ColorPalette.nearBlack
            ),
            textfield: ThemeTextfieldColors(
                text: ColorPalette.nearBlack,
                background: ColorPalette.nearWhite
            ),
            tint: ColorPalette.blue,
            title: ColorPalette.darkGray,
            background: ColorPalette.lightGray
        ),
        barStyle: .default,
        lightOpacity: 1.0,
        shadowOpacity: 0.0
    )

    static let dark: Theme = .init(
        font: ThemeFonts(),
        color: ThemeColors(
            label: ThemeLabelColors(
                text: ColorPalette.nearWhite
            ),
            textfield: ThemeTextfieldColors(
                text: ColorPalette.nearWhite,
                background: ColorPalette.gray
            ),
            tint: ColorPalette.yellow,
            title: ColorPalette.lightGray,
            background: ColorPalette.darkGray
        ),
        barStyle: .black,
        lightOpacity: 0.0,
        shadowOpacity: 1.0
    )
}
