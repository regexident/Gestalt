// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
