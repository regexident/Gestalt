//
//  ActivityIndicatorViewTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

public struct ActivityIndicatorViewTheme: Theme {
    let color: UIColor

    init(palette: Palette) {
        self.color = palette.colors.dynamic.tint
    }
}

extension UIActivityIndicatorView: Themeable {
    public typealias Theme = ActivityIndicatorViewTheme

    public func apply(theme: Theme) {
        self.color = theme.color
    }
}
