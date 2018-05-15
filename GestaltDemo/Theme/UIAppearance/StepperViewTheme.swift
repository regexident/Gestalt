//
//  StepperViewTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

struct StepperTheme: ViewTheme {
    typealias View = UIStepper

    let tintColor: UIColor

    init(palette: Palette) {
        self.tintColor = palette.colors.dynamic.tint
    }

    func theme(_ klass: View.Type) {
        let proxy = klass.appearance()

        proxy.tintColor = self.tintColor
    }
}

extension StepperTheme.View: ThemableView {}
