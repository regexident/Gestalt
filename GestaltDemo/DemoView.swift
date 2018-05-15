//
//  DemoView.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

class DemoView: UIView {

    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var label: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.theme()
    }

    func theme() {
        ThemeManager.default.apply(theme: Theme.self, to: self) { themeable, theme in
            let theme = theme.custom.demo

            themeable.titleLabel?.textColor = theme.titleColor
            themeable.titleLabel?.font = theme.titleFont

            themeable.label?.textColor = theme.labelColor
            themeable.label?.font = theme.labelFont
        }
    }
}
