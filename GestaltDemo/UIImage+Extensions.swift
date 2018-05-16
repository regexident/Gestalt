//
//  UIImage+Extensions.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/16/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit


extension UIImage {
    func tinted(color: UIColor, blendMode: CGBlendMode) -> UIImage? {
        let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        guard let cgImage = self.cgImage else {
            return nil
        }
        context.scaleBy(x: 1.0, y: -1.0)
        context.translateBy(x: 0.0, y: -self.size.height)
        context.clip(to: drawRect)
        color.setFill()
        UIRectFill(drawRect)
        context.setBlendMode(blendMode)
        context.draw(cgImage, in: drawRect)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage
    }
}
