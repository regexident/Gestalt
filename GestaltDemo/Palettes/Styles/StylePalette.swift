//
//  StylePalette.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

struct StageDesignViewStylePalette: PaletteProtocol {
    let lightOpacity: Float
    let shadowOpacity: Float

    static let light: StageDesignViewStylePalette = .init(
        lightOpacity: 0.0,
        shadowOpacity: 0.0
    )

    static let dark: StageDesignViewStylePalette = .init(
        lightOpacity: 1.0,
        shadowOpacity: 1.0
    )

    static var debug: StageDesignViewStylePalette {
        return StageDesignViewStylePalette.light
    }
}

struct StylePalette: PaletteProtocol {
    let stageDesign: StageDesignViewStylePalette

    let barStyle: UIBarStyle
    let barTranslucency: Bool
    let borderStyle: UITextBorderStyle

    static let light: StylePalette = .init(
        stageDesign: .light,
        barStyle: .default,
        barTranslucency: true,
        borderStyle: .roundedRect
    )
    
    static let dark: StylePalette = .init(
        stageDesign: .dark,
        barStyle: .black,
        barTranslucency: true,
        borderStyle: .roundedRect
    )

    static var debug: StylePalette {
        return StylePalette.light
    }
}
