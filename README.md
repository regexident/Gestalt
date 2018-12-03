![jumbotron](jumbotron.png)
# Gestalt

**Gestalt** is an **unintrusive** and **light-weight** framework for **application theming** with support for **animated theme switching**.

![screencast](screencast.gif)

## Usage

Let's say you want to theme a view controller with a single label:

```swift
import Gestalt

struct Theme: Gestalt.Theme {
    let view: ViewTheme = .init()

    static let light: Theme = .init(view: .light)
    static let dark: Theme = .init(view: .dark)
}

struct ViewTheme: Gestalt.Theme {
    let font = UIFont.preferredFont(forTextStyle: .headline)
    let color: UIColor
    let backgroundColor: UIColor

    static let light: Theme = .init(
        color: UIColor.black
        backgroundColor: UIColor.white
    )

    static let dark: Theme = .init(
        color: UIColor.white
        backgroundColor: UIColor.black
    )
}

// In `AppDelegate.application(_:didFinishLaunchingWithOptions:)`
// assign a default theme (or user's choice from user defaults):
ThemeManager.default.theme = Theme.light

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.observe(theme: \Theme.view)
    }
}

extension ViewController: Themeable {

    typealias Theme = ViewTheme

    func apply(theme: Theme) {
        self.view.backgroundColor = theme.backgroundColor
        self.label.textColor = theme.color
        self.label.font = theme.font
    }
}
```

The call `self.observe(theme: \Theme.view)` registers the receiver for theme observation on `ThemeManager.default` for future theme changes and then calls it once immediately. The initial call is not animated, any further changes however are animated.

To change the current theme (even while the app is running) simply assign a different theme to your given `ThemeManager` in use:

```swift
ThemeManager.default.theme = Theme.dark
```

This will cause all previously registered closures on the given `ThemeManager` to be called again.

See the `GestaltDemo` target for a more realistic/elaborate usage example.

#### Note:

1. It is generally sufficient to use `ThemeManager.default`. It is however possible to create dedicated `ThemeManager`s via `let manager = ThemeManager()`.

#### Important:

1. The body of `func apply(theme: Theme)` should be [idempotent](https://en.wikipedia.org/wiki/Idempotence) to avoid unwanted side-effects on repeated calls.

## Installation

The recommended way to add **Gestalt** to your project is via [Carthage](https://github.com/Carthage/Carthage):

    github 'regexident/Gestalt' ~> 2.0.0
    
or via [Cocoapods](https://cocoapods.org):

    pod 'Gestalt', '~> 2.0.0'

or via [Swift Package Manager](https://swift.org):

```swift
let package = Package(
    name: "GestaltDemo",
    dependencies: [
        .package(url: "https://github.com/regexident/Gestalt.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "GestaltDemo", dependencies: [ "Gestalt" ])
    ]
)
```

## License

**Gestalt** is available under the **MPL-2.0 license**. See the `LICENSE` file for more info.
