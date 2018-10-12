//
//  AppDelegate.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 7/3/17.
//  Copyright © 2017 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var disposables: [Disposable]?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // This window hack for catching device shake is not necessary for Gestalt to work:
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let window = ShakeableWindow(frame: UIScreen.main.bounds)
        window.rootViewController = storyboard.instantiateInitialViewController()
        window.makeKeyAndVisible()
        self.window = window

        // This stuff however is:

        typealias Theme = ApplicationTheme

        let theme = Theme.default
        let themeManager = ThemeManager.default

        themeManager.theme = theme

        self.disposables = [
            UINavigationBar.observe(theme: \Theme.native.navigationBar) { $0.appearance() },
            UITextField.observe(theme: \Theme.native.textfield) { $0.appearance() },
            UISegmentedControl.observe(theme: \Theme.native.segmentedControl) { $0.appearance() },
            UIActivityIndicatorView.observe(theme: \Theme.native.activityIndicator) { $0.appearance() },
            UIStepper.observe(theme: \Theme.native.stepper) { $0.appearance() },
            UISwitch.observe(theme: \Theme.native.switch) { $0.appearance() },
            UISlider.observe(theme: \Theme.native.slider) { $0.appearance() },
            UIButton.observe(theme: \Theme.native.button) { $0.appearance() },
        ]

        return true
    }
}
