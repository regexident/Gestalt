//
//  ThemeObserver.swift
//  Gestalt
//
//  Created by Vincent Esche on 8/6/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

#if os(iOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

internal class ThemeObserver {
    private let closure: (Theme) -> ()

    internal init(closure: @escaping (Theme) -> ()) {
        self.closure = closure
    }

    internal func handleThemeChange(on themeManager: ThemeManager) {
        assert(Thread.isMainThread)

        guard let theme = themeManager.theme else {
            var themeManager = themeManager
            Swift.withUnsafePointer(to: &themeManager) {
                NSLog("No theme found for theme manager \($0)")
            }
            return
        }
        themeManager.animated(duration: themeManager.animationDuration) {
            self.closure(theme)
        }
    }
}
