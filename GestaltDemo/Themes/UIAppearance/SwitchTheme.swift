//
//  SwitchTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

public struct SwitchTheme: Theme {
    let tintColor: UIColor

    init(palette: Palette) {
        self.tintColor = palette.colors.dynamic.tint
    }
}

extension UISwitch: Themeable {
    public typealias Theme = SwitchTheme

    public func apply(theme: Theme) {
        self.onTintColor = theme.tintColor
    }
}
