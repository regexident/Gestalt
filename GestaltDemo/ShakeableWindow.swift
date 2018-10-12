//
//  ShakeableWindow.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

class ShakeableWindow: UIWindow {
    var previousTheme: Theme? = nil
    var debugThemeEnabled : Bool = false

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else {
            return
        }

        self.toggleDebugTheme()
    }

    private func toggleDebugTheme() {
        if self.debugThemeEnabled {
            ThemeManager.default.theme = self.previousTheme
            self.previousTheme = nil
        } else {
            ThemeManager.default.theme = ApplicationTheme.debug
            self.previousTheme = ThemeManager.default.theme
        }
        self.debugThemeEnabled = !self.debugThemeEnabled
    }
}
