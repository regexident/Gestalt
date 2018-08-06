//
//  SliderTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

public struct SliderTheme: Theme {
    let tintColor: UIColor

    init(palette: Palette) {
        self.tintColor = palette.colors.dynamic.tint
    }
}

extension UISlider: Themeable {
    public typealias Theme = SliderTheme

    public func apply(theme: Theme) {
        self.tintColor = theme.tintColor
    }
}
