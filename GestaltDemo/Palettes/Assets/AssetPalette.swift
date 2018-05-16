//
//  AssetPalette.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

struct StageDesignViewAssetPalette: PaletteProtocol {
    let lightImage: UIImage = UIImage(named: "Light")!
    let fixtureImage: UIImage
    let shadowImage: UIImage = UIImage(named: "Shadow")!

    static let light: StageDesignViewAssetPalette = .init(
        fixtureImage: UIImage(named: "FixtureLight")!
    )
    
    static let dark: StageDesignViewAssetPalette = .init(
        fixtureImage: UIImage(named: "FixtureDark")!
    )

    static var debug: StageDesignViewAssetPalette {
        let image = UIImage(named: "FixtureLight")!
        let tintedImage = image.tinted(color: UIColor.magenta, blendMode: .color)!
        return StageDesignViewAssetPalette(fixtureImage: tintedImage)
    }
}

struct AssetPalette: PaletteProtocol {
    let stageDesign: StageDesignViewAssetPalette

    static let light: AssetPalette = .init(
        stageDesign: .light
    )

    static let dark: AssetPalette = .init(
        stageDesign: .dark
    )

    static let debug: AssetPalette = .init(
        stageDesign: .debug
    )
}
