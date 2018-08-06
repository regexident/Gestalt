//
//  StageDesignViewTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

struct StageDesignViewTheme: Theme {
    let backgroundColor: UIColor

    let lightOpacity: Float
    let shadowOpacity: Float

    let lightImage: UIImage
    let fixtureImage: UIImage
    let shadowImage: UIImage

    init(palette: Palette) {
        let colorsPalette = palette.colors
        self.backgroundColor = colorsPalette.dynamic.background

        let stylesPalette = palette.styles.stageDesign
        self.lightOpacity = stylesPalette.lightOpacity
        self.shadowOpacity = stylesPalette.shadowOpacity

        let assetsPalette = palette.assets.stageDesign
        self.lightImage = assetsPalette.lightImage
        self.fixtureImage = assetsPalette.fixtureImage
        self.shadowImage = assetsPalette.shadowImage
    }
}
