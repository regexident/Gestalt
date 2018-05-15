//
//  DemoViewTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

struct DemoViewTheme {
    let titleColor: UIColor
    let titleFont: UIFont

    let labelColor: UIColor
    let labelFont: UIFont

    init(palette: Palette) {
        let colorsPalette = palette.colors
        let fontsPalette = palette.fonts

        self.titleColor = colorsPalette.dynamic.foreground
        self.titleFont = fontsPalette.dynamic.headline

        self.labelColor = colorsPalette.dynamic.foreground
        self.labelFont = fontsPalette.dynamic.subheadline
    }
}
