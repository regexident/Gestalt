//
//  NavigationBarTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

public struct NavigationBarTheme: Theme {
    let barStyle: UIBarStyle
    let titleFont: UIFont
    let titleColor: UIColor
    let tintColor: UIColor
    let isTranslucent: Bool

    init(palette: Palette) {
        self.barStyle = palette.styles.barStyle
        self.titleFont = palette.fonts.static.navigationBarTitle
        self.titleColor = palette.colors.dynamic.primary
        self.tintColor = palette.colors.dynamic.tint
        self.isTranslucent = palette.styles.barTranslucency
    }
}

extension UINavigationBar: Themeable {
    public typealias Theme = NavigationBarTheme

    public func apply(theme: Theme) {
        self.barStyle = theme.barStyle
        self.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: theme.titleColor,
            NSAttributedStringKey.font: theme.titleFont
        ]

        self.isTranslucent = theme.isTranslucent
        self.tintColor = theme.tintColor
    }
}
