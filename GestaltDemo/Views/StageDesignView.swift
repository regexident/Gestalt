//
//  StageDesignView.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

@IBDesignable
class StageDesignView: UIView {
    @IBOutlet private var lightView: UIImageView?
    @IBOutlet private var fixtureView: UIImageView?
    @IBOutlet private var shadowView: UIImageView?

    override func prepareForInterfaceBuilder() {
        self.theme()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.theme()
    }

    func theme() {
        ThemeManager.default.apply(theme: Theme.self, to: self) { themeable, theme in
            let theme = theme.custom.stageDesign

            UIView.performWithoutAnimation {
                themeable.backgroundColor = theme.backgroundColor
                themeable.shadowView?.layer.opacity = theme.shadowOpacity
            }

            UIView.animate(withDuration: 5.0, animations: {
                themeable.lightView?.layer.opacity = theme.lightOpacity
            })

            themeable.lightView?.image = theme.lightImage
            themeable.fixtureView?.image = theme.fixtureImage
            themeable.shadowView?.image = theme.shadowImage
        }
    }
}
