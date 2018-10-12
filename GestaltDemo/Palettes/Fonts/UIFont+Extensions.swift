//
//  UIFont+Extensions.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

extension UIFont {
    class func preferredFont(
        withName fontName: String,
        textStyle style: UIFont.TextStyle
    ) -> UIFont {
        let descriptor = UIFontDescriptor.preferredFontDescriptor(
            withName: fontName,
            textStyle: style
        )
        return UIFont(descriptor: descriptor, size: descriptor.pointSize)
    }
}

extension UIFontDescriptor {
    class func preferredFontDescriptor(
        withName fontName: String,
        textStyle: UIFont.TextStyle
    ) -> UIFontDescriptor {
        let size = self.preferredFontDescriptor(withTextStyle: textStyle).pointSize
        return UIFontDescriptor(name: fontName, size: size)
    }
}
