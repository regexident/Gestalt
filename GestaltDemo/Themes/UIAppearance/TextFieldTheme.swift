//
//  TextFieldTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

public struct TextFieldTheme: Theme {
    let font: UIFont
    let borderStyle: UITextField.BorderStyle
    let textColor: UIColor
    let backgroundColor: UIColor

    init(palette: Palette) {
        self.font = palette.fonts.dynamic.body
        self.borderStyle = palette.styles.borderStyle
        self.textColor = palette.colors.dynamic.primary
        self.backgroundColor = palette.colors.dynamic.complementary
    }
}

extension UITextField: Themeable {
    public typealias Theme = TextFieldTheme

    public func apply(theme: Theme) {
        self.textColor = theme.textColor
        self.backgroundColor = theme.backgroundColor
        self.borderStyle = theme.borderStyle
        self.font = theme.font
    }
}
