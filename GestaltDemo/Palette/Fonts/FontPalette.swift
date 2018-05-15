//
//  FontPalette.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

struct DynamicFontPalette {
    let title1: UIFont
    let title2: UIFont
    let title3: UIFont
    let headline: UIFont
    let subheadline: UIFont
    let body: UIFont
    let footnote: UIFont
    let callout: UIFont
    let caption1: UIFont
    let caption2: UIFont
}

struct StaticFontPalette {
    let navigationBarTitle: UIFont
    let label: UIFont
    let textfield: UIFont
}

struct FontPalette: PaletteProtocol {
    let dynamic: DynamicFontPalette
    let `static`: StaticFontPalette

    static var `default`: FontPalette {
        return FontPalette.light
    }

    static let light: FontPalette = .init(
        dynamic: .init(
            title1: UIFont.preferredFont(forTextStyle: .title1),
            title2: UIFont.preferredFont(forTextStyle: .title2),
            title3: UIFont.preferredFont(forTextStyle: .title3),
            headline: UIFont.preferredFont(forTextStyle: .headline),
            subheadline: UIFont.preferredFont(forTextStyle: .subheadline),
            body: UIFont.preferredFont(forTextStyle: .body),
            footnote: UIFont.preferredFont(forTextStyle: .footnote),
            callout: UIFont.preferredFont(forTextStyle: .callout),
            caption1: UIFont.preferredFont(forTextStyle: .caption1),
            caption2: UIFont.preferredFont(forTextStyle: .caption2)
        ),
        static: .init(
            navigationBarTitle: UIFont.systemFont(ofSize: 18.0, weight: .bold),
            label: UIFont.systemFont(ofSize: 17.0, weight: .bold),
            textfield: UIFont.systemFont(ofSize: 14.0, weight: .bold)
        )
    )

    static var dark: FontPalette {
        return FontPalette.light // same as `.light` for now.
    }

    static let debug: FontPalette = .init(
        dynamic: .init(
            title1: BlokkNeueFont.with(textStyle: .title1),
            title2: BlokkNeueFont.with(textStyle: .title2),
            title3: BlokkNeueFont.with(textStyle: .title3),
            headline: BlokkNeueFont.with(textStyle: .headline),
            subheadline: BlokkNeueFont.with(textStyle: .subheadline),
            body: BlokkNeueFont.with(textStyle: .body),
            footnote: BlokkNeueFont.with(textStyle: .footnote),
            callout: BlokkNeueFont.with(textStyle: .callout),
            caption1: BlokkNeueFont.with(textStyle: .caption1),
            caption2: BlokkNeueFont.with(textStyle: .caption2)
        ),
        static: .init(
            navigationBarTitle: UIFont.systemFont(ofSize: 18.0, weight: .bold),
            label: UIFont.systemFont(ofSize: 17.0, weight: .bold),
            textfield: UIFont.systemFont(ofSize: 14.0, weight: .bold)
        )
    )
}
