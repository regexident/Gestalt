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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.

        // This window hack if not necessary for Gestalt inn general:
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let window = ShakeableWindow(frame: UIScreen.main.bounds)
        window.rootViewController = storyboard.instantiateInitialViewController()
        window.makeKeyAndVisible()
        self.window = window

        // This line however is:
        ThemeManager.default.theme = Theme.default

        // As is this block if you're doing any UIAppearance-related theming:
        ThemeManager.default.apply(theme: Theme.self, to: self) { themable, theme in
            UINavigationBar.apply(theme: theme.native.navigationBar)
            UITextField.apply(theme: theme.native.textfield)
            UISegmentedControl.apply(theme: theme.native.segmentedControl)
            UIActivityIndicatorView.apply(theme: theme.native.activityIndicator)
            UIStepper.apply(theme: theme.native.stepper)
            UISwitch.apply(theme: theme.native.switch)
            UISlider.apply(theme: theme.native.slider)
            UIButton.apply(theme: theme.native.button)
            
            for window in UIApplication.shared.windows {
                for view in window.subviews {
                    view.removeFromSuperview()
                    window.addSubview(view)
                }
            }
        }

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its theme state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

