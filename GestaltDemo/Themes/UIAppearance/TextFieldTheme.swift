//
//  TextFieldTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

struct TextFieldTheme: AppearanceTheme {
    typealias View = UITextField

    let font: UIFont
    let borderStyle: UITextBorderStyle
    let textColor: UIColor
    let backgroundColor: UIColor

    init(palette: Palette) {
        self.font = palette.fonts.dynamic.body
        self.borderStyle = palette.styles.borderStyle
        self.textColor = palette.colors.dynamic.primary
        self.backgroundColor = palette.colors.dynamic.complementary
    }

    func theme(_ klass: View.Type) {
        let proxy = klass.appearance()

        proxy.textColor = self.textColor
        proxy.backgroundColor = self.backgroundColor
        proxy.borderStyle = self.borderStyle
        proxy.font = self.font
    }
}

extension TextFieldTheme.View: AppearanceThemeView {}
