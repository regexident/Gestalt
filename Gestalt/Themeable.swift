//
//  Themeable.swift
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

/// Utility protocol for enabling Gestalt themes
public protocol Themeable: class {
    associatedtype Theme: Gestalt.Theme

    /// The implementation of this function should be [idempotent](https://en.wikipedia.org/wiki/Idempotence)
    /// to avoid unwanted side-effects on repeated calls.
    func apply(theme: Theme)
}

extension Themeable {
    public func observe<T>(
        theme keyPath: KeyPath<T, Theme>,
        on themeManager: ThemeManager = .default
    )
        where T: Gestalt.Theme
    {
        themeManager.manage(theme: keyPath, for: self)
    }
}

#if os(iOS)
extension Themeable where Self: UIAppearance {
    public static func observe<T>(
        theme keyPath: KeyPath<T, Theme>,
        on themeManager: ThemeManager = .default,
        appearance: @escaping (Self.Type) -> Self
    ) -> Disposable
        where T: Gestalt.Theme
    {
        return themeManager.observe(theme: T.self) { theme in
            self.apply(theme: theme[keyPath: keyPath], appearance: appearance)
        }
    }

    public static func apply(theme: Theme, appearance: (Self.Type) -> Self) {
        appearance(self).apply(theme: theme)
    }
}
#endif

public typealias AnyThemeable = AnyObject
