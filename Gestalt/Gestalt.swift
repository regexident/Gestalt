//
//  Gestalt.swift
//  Gestalt
//
//  Created by Vincent Esche on 7/3/17.
//  Copyright © 2017 Vincent Esche. All rights reserved.
//

import Foundation

#if os(iOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

/// Tagging protocol for Gestalt themes
public protocol ThemeProtocol {}

/// Utility protocol for enabling Gestalt themes
public typealias Themeable = AnyObject

/// Theme manager for assigning a theme
public class ThemeManager {
    /// The default ThemeManager
    public static let `default`: ThemeManager = .init()

    /// Notification used for broadcasting theme changes
    public static let notificationName = Notification.Name("Gestalt.ThemeChangedNotification")

    /// NotificationCenter used for broadcasting theme changes
    public var notificationCenter: NotificationCenter = .init()

    /// Whether to apply themes with animation
    public var animated: Bool = true

    /// Duration of animation during theme application
    public var animationDuration: TimeInterval = 0.4

    /// The current theme
    public var theme: ThemeProtocol? {
        willSet {
            guard
                let oldValue = self.theme,
                let newValue = newValue
            else {
                return
            }
            let old = type(of: oldValue)
            let new = type(of: newValue)
            if old != new {
                NSLog("Warning: Switching from theme of type \(old) to theme of type \(new).")
            }
        }
        didSet {
            self.notify()
        }
    }

    fileprivate struct WeakBox : Hashable {
        weak var inner: ThemeManager?

        init(_ inner: ThemeManager) {
            self.inner = inner
        }

        static func == (lhs: WeakBox, rhs: WeakBox) -> Bool {
            return lhs.inner === rhs.inner
        }

        var hashValue: Int {
            guard let inner = self.inner else {
                return 0
            }
            return ObjectIdentifier(inner).hashValue
        }
    }

    fileprivate static var managers: Set<WeakBox> = []

    /// Creates a `ThemeManager` instance
    ///
    /// - Note:
    ///   Consider using `ThemeManager.default` instead of creating your own instances.
    ///   It should cover 99% of your use-cases.
    public init() {
        ThemeManager.managers.insert(WeakBox(self))
    }

    /// Supplies the current theme to the sender for easy theming.
    ///
    /// - Parameters:
    ///   - theme: the theme to apply
    ///   - themeable: the object to have the theme applied to
    ///   - animated: whether to animate the initial theme application
    ///   - closure: closure for applying provided the theme to the sender
    ///
    /// - Note:
    ///   The value passed to `animated` overrides the `ThemeManager`'s default setting
    ///   of `var animated: Bool` for the initial call of the closure.
    ///
    /// - Important:
    ///   1. Within `closure` any access on `themeable` should only achieved through
    ///      the closure's `$0` argument, not directly, to avoid retain cycles.
    ///   2. The body of `closure` should be [idempotent](https://en.wikipedia.org/wiki/Idempotence)
    ///      to avoid unwanted side-effects on repeated calls.
    public func apply<T, U>(theme: T.Type, to themeable: U, animated: Bool = false, closure: @escaping (U, T) -> ())
        where T: ThemeProtocol, U: Themeable
    {
        let animationDuration = (animated) ? self.animationDuration : 0.0
        if let theme = self.theme as? T {
            animate(duration: animationDuration) {
                closure(themeable, theme)
            }
        } else {
            var themeManager = self
            withUnsafePointer(to: &themeManager) {
                NSLog("No theme found for theme manager \($0)")
            }
        }
        let observer = ThemeableObserver.gestaltObserver(for: themeable, on: self)
        observer.observe(self)
        observer.register(theme.self) {themeable, theme in
            guard let themeable = themeable as? U else {
                return
            }
            guard let theme = theme as? T else {
                return
            }
            closure(themeable, theme)
        }
    }

    fileprivate func notify() {
        DispatchQueue.global().async {
            self.notificationCenter.post(
                name: ThemeManager.notificationName,
                object: self
            )
        }
    }
}

fileprivate func animate(duration: TimeInterval, closure: @escaping () -> ()) {
    #if os(iOS)
        UIView.animate(withDuration: duration) {
            closure()
        }
    #else
        closure()
    #endif
}

internal class ThemeableObserver {
    internal enum Key {
        static let associatedObject = ObjectIdentifier(ThemeableObserver.self)
    }

    fileprivate typealias Observation = (Themeable, ThemeProtocol) -> ()

    private weak var themeable: Themeable?

    private var themeObserver: NSObjectProtocol!
    private var dynamicTypeObserver: NSObjectProtocol!
    private var observations: [ObjectIdentifier: Observation] = [:]

    private init(themeable: Themeable, manager: ThemeManager) {
        self.themeable = themeable
        self.attach(to: themeable)
    }

    fileprivate static func gestaltObserver(
        for themeable: Themeable, on manager: ThemeManager
    ) -> ThemeableObserver {
        var key = ThemeableObserver.Key.associatedObject
        if let observer = objc_getAssociatedObject(self, &key) as? ThemeableObserver {
            return observer
        }
        return ThemeableObserver(themeable: themeable, manager: manager)
    }

    fileprivate func register<T>(_ theme: T.Type, closure: @escaping Observation)
        where T: ThemeProtocol
    {
        let key = ObjectIdentifier(theme)
        if self.observations[key] != nil {
            let themeName = String(describing: theme.self)
            let themeableName = String(describing: type(of: self))
            NSLog("Warning: Replacing existing observer for \(themeName) in \(themeableName).")
        }
        self.observations[key] = closure
    }

    fileprivate func attach(to themeable: Themeable) {
        var key = Key.associatedObject
        objc_setAssociatedObject(themeable, &key, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    fileprivate func observe(_ themeManager: ThemeManager) {
        themeManager.notificationCenter.addObserver(
            self,
            selector: #selector(ThemeableObserver.handleThemeChange(_:)),
            name: ThemeManager.notificationName,
            object: themeManager
        )
        #if os(iOS)
        if #available(iOS 7, *) {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(ThemeableObserver.handleDynamicTypeChange(_:)),
                name: NSNotification.Name.UIContentSizeCategoryDidChange,
                object: nil
            )
        }
        #endif
    }

    @objc private func handleThemeChange(_ notification: Notification) {
        guard let themeManager = notification.object as? ThemeManager else {
            return
        }
        guard let theme = themeManager.theme else {
            var themeManager = themeManager
            withUnsafePointer(to: &themeManager) {
                NSLog("No theme found for theme manager \($0)")
            }
            return
        }
        let themeKey = ObjectIdentifier(type(of: theme))
        guard let closure = self.observations[themeKey] else {
            return
        }
        guard let themeable = self.themeable else {
            return
        }
        let animationDuration = themeManager.animated ? themeManager.animationDuration : 0.0
        DispatchQueue.main.async {
            animate(duration: animationDuration) {
                closure(themeable, theme)
            }
        }
    }

    @available(iOS 7, *)
    @objc private func handleDynamicTypeChange(_ notification: Notification) {
        for boxedManager in ThemeManager.managers {
            guard let manager = boxedManager.inner else {
                ThemeManager.managers.remove(boxedManager)
                continue
            }
            manager.notify()
        }
    }
}
