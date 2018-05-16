//
//  Palette.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

protocol PaletteProtocol {
    static var light: Self { get }
    static var dark: Self { get }

    static var debug: Self { get }
}

struct Palette: PaletteProtocol {
    let colors: ColorPalette
    let fonts: FontPalette
    let assets: AssetPalette
    let styles: StylePalette

    static let light: Palette = .init(
        colors: .light,
        fonts: .light,
        assets: .light,
        styles: .light
    )

    static let dark: Palette = .init(
        colors: .dark,
        fonts: .dark,
        assets: .dark,
        styles: .dark
    )

    static let debug: Palette = .init(
        colors: .debug,
        fonts: .debug,
        assets: .debug,
        styles: .debug
    )
}
