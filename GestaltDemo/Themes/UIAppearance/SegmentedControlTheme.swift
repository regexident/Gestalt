//
//  SegmentedControlTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

public struct SegmentedControlTheme: Theme {
    let tintColor: UIColor

    init(palette: Palette) {
        self.tintColor = palette.colors.dynamic.tint
    }
}

extension UISegmentedControl: Themeable {
    public typealias Theme = SegmentedControlTheme

    public func apply(theme: Theme) {
        self.tintColor = theme.tintColor
    }
}
