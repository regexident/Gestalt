//
//  TableViewController.swift
//  Gestalt
//
//  Created by Vincent Esche on 7/3/17.
//  Copyright © 2017 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

class DemoViewController: UIViewController {

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
        self.editButtonItem.action = #selector(DemoViewController.toggleTheme(_:))
        self.editButtonItem.title = "Switch Light"
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

    @IBAction private func openVideo(_ sender: UIButton) {
        // Funny Talking Animals - Walk On The Wild Side - Episode Three Preview - BBC One:
        if let link = URL(string: "https://www.youtube.com/watch?v=EQ1HKCYJM5U") {
            UIApplication.shared.open(link)
        }

    }
}
