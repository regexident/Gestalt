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
    @IBOutlet private var titleLabel: UILabel?
    @IBOutlet private var label: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()

        self.observe(theme: \ApplicationTheme.custom.demo)
    }
}

extension DemoView: Themeable {
    typealias Theme = DemoViewTheme

    func apply(theme: Theme) {
        self.titleLabel?.textColor = theme.titleColor
        self.titleLabel?.font = theme.titleFont

        self.label?.textColor = theme.labelColor
        self.label?.font = theme.labelFont
    }
}
