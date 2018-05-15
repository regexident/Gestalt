//
//  NavigationBarTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

struct NavigationBarTheme: AppearanceTheme {
    typealias View = UINavigationBar

    let barStyle: UIBarStyle
    let titleFont: UIFont
    let titleColor: UIColor
    let tintColor: UIColor

    init(palette: Palette) {
        self.barStyle = palette.styles.barStyle
        self.titleFont = palette.fonts.static.navigationBarTitle
        self.titleColor = palette.colors.dynamic.primary
        self.tintColor = palette.colors.dynamic.tint
    }

    func theme(_ klass: View.Type) {
        let proxy = klass.appearance()
        
        proxy.barStyle = self.barStyle
        proxy.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: self.titleColor,
            NSAttributedStringKey.font: self.titleFont
        ]

        proxy.isTranslucent = true
        proxy.tintColor = self.tintColor
    }
}

extension NavigationBarTheme.View: AppearanceThemeView {}
