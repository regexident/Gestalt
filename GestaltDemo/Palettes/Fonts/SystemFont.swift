//
//  SystemFont.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

enum SystemFont {
    typealias Weight = UIFont.Weight

    static func with(textStyle: UIFont.TextStyle) -> UIFont {
        return UIFont.preferredFont(forTextStyle: textStyle)
    }

    static func with(size: CGFloat, weight: Weight = .regular) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
}
