
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

#if os(iOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif

internal struct InvalidThemeError: Error {
    // intentionally left blank
}

internal struct RedundantObservationError: Error {
    // intentionally left blank
}

/// Theme manager for assigning a theme
public class ThemeManager {
    /// The default ThemeManager
    public static let `default`: ThemeManager = .init()

    /// Whether to apply themes with animation
    public var animated: Bool = true

    /// Duration of animation during theme application
    public var animationDuration: TimeInterval = 3.0 // 0.4

    // Notification used for broadcasting theme changes
    private static let notificationName = Notification.Name("Gestalt.ThemeChangedNotification")

    // NotificationCenter used for broadcasting theme changes
    private var notificationCenter: NotificationCenter = .init()
    
    // For appearance hack (see below), only accessible in iOS Applications
    #if os(iOS)
    private let optionalSharedApplication: UIApplication? = {
        let sharedSelector = NSSelectorFromString("sharedApplication")
        guard UIApplication.responds(to: sharedSelector) else {
            // Extensions cannot access UIApplication
            return nil
        }
        let shared = UIApplication.perform(sharedSelector)
        return shared?.takeUnretainedValue() as? UIApplication
    }()
    #endif

    /// The current theme.
    ///
    /// - Important:
    /// Upon receiving an initial value any future values are expected to be of the same type.
    public var theme: Theme? {
        willSet {
            #if DEBUG
            guard let currentValue = self.theme else {
                return
            }
            guard let newValue = newValue else {
                return
            }
            let currentThemeType = type(of: currentValue)
            let newThemeType = type(of: newValue)
            if currentThemeType != newThemeType {
                typealias ErrorType = InvalidThemeError
                let errorName = String(describing: ErrorType.self)
                let expected = String(describing: currentThemeType)
                let found = String(describing: newThemeType)
                print("\(self): Expected theme of type \(expected), found: \(found).")
                print("Info: Use a \"Swift Error Breakpoint\" on type \"Gestalt.\(errorName)\" to catch.")
                do {
                    throw ErrorType()
                } catch {
                    // intentionally left blank
                }
            }
            #endif
        }
        didSet {
            self.notify()
        }
    }

    private var observations: Set<ObjectIdentifier> = []

    /// Creates a `ThemeManager` instance
    ///
    /// - Note:
    ///   Consider using `ThemeManager.default` instead of creating your own instances.
    ///   It should cover 99% of your use-cases.
    public init() {
        #if os(iOS)
        if #available(iOS 7, *) {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(ThemeManager.handleDynamicTypeChange(_:)),
                name: UIContentSizeCategory.didChangeNotification,
                object: nil
            )
        }
        #endif
    }

    /// Provides automated theme management for `themeable`.
    ///
    /// - Parameters:
    ///   - theme: `themeable`'s sub-theme's key-path relative to the Manager's current theme to apply
    ///   - themeable: the object to have the theme applied to
    public func manage<T, U>(
        theme keyPath: KeyPath<T, U.Theme>,
        for themeable: U
    )
        where T: Gestalt.Theme, U: Themeable
    {
        let identifier = ObjectIdentifier(themeable)
        if self.observations.contains(identifier) {
            typealias ErrorType = RedundantObservationError
            let errorName = String(describing: ErrorType.self)
            let description = String(describing: themeable)
            print("\(self): Detected redundant observation of \(description).")
            print("Info: Use a \"Swift Error Breakpoint\" on type \"Gestalt.\(errorName)\" to catch.")
            do {
                throw ErrorType()
            } catch {
                // intentionally left blank
            }
        }
        self.observations.insert(identifier)

        let disposable = self.observe(theme: T.self) { [weak themeable] theme in
            guard let strongThemeable = themeable else {
                return
            }
            strongThemeable.apply(theme: theme[keyPath: keyPath])
        }

        var associatedObjectKey = ObjectIdentifier(ThemeManager.self)
        objc_setAssociatedObject(
            themeable,
            &associatedObjectKey,
            disposable,
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }

    /// Provides automated theme notification via `closure`.
    ///
    /// - Parameters:
    ///   - theme: the theme to apply
    ///   - closure: closure for applying provided the theme to the sender
    ///
    /// - Important:
    ///   1. Within `closure` any access on "closed over" objects
    ///      must be guarded by `[weak ...]` to avoid retain cycles.
    ///   2. The body of `closure` should be [idempotent](https://en.wikipedia.org/wiki/Idempotence)
    ///      to avoid unwanted side-effects on repeated calls.
    public func observe<T>(
        theme: T.Type,
        closure: @escaping (T) -> ()
    ) -> Disposable
        where T: Gestalt.Theme
    {
        #if DEBUG
        if let currentTheme = self.theme, type(of: currentTheme) != theme {
            typealias ErrorType = InvalidThemeError
            let errorName = String(describing: ErrorType.self)
            let expected = String(describing: type(of: currentTheme))
            let found = String(describing: theme)
            print("\(self): Expected observation of type \(expected), found: \(found).")
            print("Info: Use a \"Swift Error Breakpoint\" on type \"Gestalt.\(errorName)\" to catch.")
            do {
                throw ErrorType()
            } catch {
                // intentionally left blank
            }
        }
        #endif

		let observer = ThemeObserver { theme in
            guard let theme = theme as? T else {
                return
            }
            closure(theme)
        }

        self.add(observer: observer)

        if let theme = self.theme as? T {
            closure(theme)
        }

        // Strongly references the observer (required):
        return Disposable { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.remove(observer: observer)
        }
    }

    private func add(observer: ThemeObserver) {
        self.notificationCenter.addObserver(
            forName: ThemeManager.notificationName,
            object: self,
            queue: OperationQueue.main
        ) { [weak observer] notification in
            guard let themeManager = notification.object as? ThemeManager else {
                return
            }
            guard let strongObserver = observer else {
                return
            }
            strongObserver.handleThemeChange(on: themeManager)
        }
    }

    private func remove(observer: ThemeObserver) {
        self.notificationCenter.removeObserver(
            observer,
            name: ThemeManager.notificationName,
            object: self
        )
    }

    private func notify() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.notificationCenter.post(
                name: ThemeManager.notificationName,
                object: strongSelf
            )

            // NotificationCenter notifies its observers
            // synchronously, so we do not need to wait:

            #if os(iOS)
            // HACK: apparently the only way to
            // change the appearance of existing instances:
            if let sharedApplication = self?.optionalSharedApplication {
                for window in sharedApplication.windows {
                    for view in window.subviews {
                        view.removeFromSuperview()
                        window.addSubview(view)
                    }
                }
            }
            #endif
        }
    }

    internal func animated(duration: TimeInterval, closure: @escaping () -> ()) {
        #if os(iOS)
        UIView.animate(withDuration: duration) {
            closure()
        }
        #else
        closure()
        #endif
    }

    @available(iOS 7, *)
    @objc private func handleDynamicTypeChange(_ notification: Notification) {
        self.notify()
    }
}

extension ThemeManager: CustomStringConvertible {
    public var description: String {
        var mutableSelf = self
        return Swift.withUnsafePointer(to: &mutableSelf) { pointer in
            let name = String(describing: type(of: self))
            let address = String(format: "%p", pointer)
            return "<\(name): \(address)>"
        }
    }
}
