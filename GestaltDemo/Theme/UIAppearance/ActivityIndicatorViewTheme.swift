//
//  ActivityIndicatorViewTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

struct ActivityIndicatorViewTheme: ViewTheme {
    typealias View = UIActivityIndicatorView

    let color: UIColor

    init(palette: Palette) {
        self.color = palette.colors.dynamic.tint
    }

    func theme(_ klass: View.Type) {
        let proxy = klass.appearance()

        proxy.color = self.color
    }
}

extension ActivityIndicatorViewTheme.View: ThemableView {}
