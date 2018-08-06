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

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.observe(theme: \ApplicationTheme.custom.stageDesign)
    }
}

extension StageDesignView: Themeable {
    typealias Theme = StageDesignViewTheme

    func apply(theme: Theme) {
        UIView.performWithoutAnimation {
            self.backgroundColor = theme.backgroundColor
            self.shadowView?.layer.opacity = theme.shadowOpacity
        }

        UIView.animate(withDuration: 5.0, animations: {
            self.lightView?.layer.opacity = theme.lightOpacity
        })

        self.lightView?.image = theme.lightImage
        self.fixtureView?.image = theme.fixtureImage
        self.shadowView?.image = theme.shadowImage
    }
}
