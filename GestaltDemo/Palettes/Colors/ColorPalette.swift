//
//  ColorPalette.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

struct StaticPalette {
    let brand: UIColor
}

struct DynamicPalette {
    let foreground: UIColor
    let background: UIColor

    let primary: UIColor
    let secondary: UIColor
    let complementary: UIColor

    let tint: UIColor
}

struct ColorPalette: PaletteProtocol {
    let `static`: StaticPalette
    let dynamic: DynamicPalette

    static var `default`: ColorPalette {
        return ColorPalette.light
    }

    static let light: ColorPalette = .init(
        static: .init(
            brand: UIColor(hue:0.568, saturation:0.683, brightness:0.854, alpha:1) // UIKonf blue
        ),
        dynamic: .init(
            foreground: UIColor(hue:0.635, saturation:0.1, brightness:0.1, alpha:1), // near black
            background: UIColor(hue:0.121, saturation:0.1, brightness:0.95, alpha:1), // near white

            primary: UIColor(hue: 0.635, saturation: 0.101, brightness: 0.2, alpha: 1), // dark gray
            secondary: UIColor(hue: 0.121, saturation: 0.101, brightness: 0.5, alpha: 1), // gray
            complementary: UIColor(hue:0.121, saturation:0.144, brightness:0.793, alpha:1), // light gray

            tint: UIColor(hue:0.620, saturation:0.75, brightness:1.0, alpha:1) // blue
        )
    )

    static let dark: ColorPalette = .init(
        static: .init(
            brand: UIColor(hue:0.568, saturation:0.683, brightness:0.854, alpha:1) // UIKonf blue
        ),
        dynamic: .init(
            foreground: UIColor(hue:0.121, saturation:0.1, brightness:0.95, alpha:1), // near white
            background: UIColor(hue:0.635, saturation:0.1, brightness:0.1, alpha:1), // near black

            primary: UIColor(hue:0.121, saturation:0.144, brightness:0.793, alpha:1), // light gray
            secondary: UIColor(hue: 0.121, saturation: 0.101, brightness: 0.5, alpha: 1), // gray
            complementary: UIColor(hue: 0.635, saturation: 0.101, brightness: 0.2, alpha: 1), // dark gray

            tint: UIColor(hue:0.129, saturation:0.702, brightness:0.992, alpha:1) // yellow
        )
    )

    static let debug: ColorPalette = .init(
        static: .init(
            brand: UIColor.magenta
        ),
        dynamic: .init(
            foreground: UIColor(hue:0.833, saturation:0.05, brightness:1, alpha:1), // near-white magenta,
            background: UIColor(hue:0.833, saturation:0.95, brightness:0.2, alpha:1), // near-black magenta

            primary: UIColor(hue:0.833, saturation:0.5, brightness:1, alpha:1), // light magenta
            secondary: UIColor(hue:0.833, saturation:0.75, brightness:1, alpha:1), // desaturated magenta
            complementary: UIColor(hue:0.833, saturation:0.75, brightness:0.5, alpha:1), // dark magenta

            tint: UIColor(hue:0.833, saturation:1, brightness:1, alpha:1) // magenta
        )
    )
}
