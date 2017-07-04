//
//  TableViewController.swift
//  Gestalt
//
//  Created by Vincent Esche on 7/3/17.
//  Copyright © 2017 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

struct MyTheme: ThemeProtocol {

}

class ViewController: UIViewController {

    enum CellReuseIdentifier: String {
        case cell
    }

    @IBOutlet var shadowView: UIImageView!
    @IBOutlet var fixtureView: UIImageView!
    @IBOutlet var lightView: UIImageView!

    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var label: UILabel!
    @IBOutlet var checkbox: UISwitch!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var slider: UISlider!
    @IBOutlet var textfield: UITextField!
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var button: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Gestalt"

        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.editButtonItem.target = self
        self.editButtonItem.action = #selector(ViewController.toggleTheme(_:))
        self.editButtonItem.title = "Switch Light"

        ThemeManager.default.apply(theme: Theme.self, to: self) { themeable, theme in
            themeable.view.backgroundColor = theme.color.background

            let navigationBar = themeable.navigationController?.navigationBar
            navigationBar?.tintColor = theme.color.tint
            navigationBar?.barStyle = theme.barStyle

            themeable.titleLabel.textColor = theme.color.title
            themeable.titleLabel.font = theme.font.title

            themeable.segmentedControl.tintColor = theme.color.tint

            themeable.slider.tintColor = theme.color.tint

            themeable.button.tintColor = theme.color.tint

            themeable.stepper.tintColor = theme.color.tint
            
            themeable.activityIndicator.color = theme.color.tint

            themeable.checkbox.onTintColor = theme.color.tint

            themeable.label.textColor = theme.color.label.text
            themeable.label.font = theme.font.label

            themeable.textfield.textColor = theme.color.textfield.text
            themeable.textfield.backgroundColor = theme.color.textfield.background
            themeable.textfield.borderStyle = .roundedRect
            themeable.textfield.font = theme.font.textfield

            themeable.lightView.layer.opacity = theme.lightOpacity
            themeable.shadowView.layer.opacity = theme.shadowOpacity
        }
    }

    private var isDark: Bool = false

    @objc private func toggleTheme(_ sender: UIBarItem) {
        if self.isDark {
            ThemeManager.default.theme = Theme.light

            self.titleLabel.text = "Day Time!"
        } else {
            ThemeManager.default.theme = Theme.dark

            self.titleLabel.text = "Night Time!"
        }
        self.isDark = !self.isDark
    }
}
