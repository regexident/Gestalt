//
//  ViewTheme.swift
//  GestaltDemo
//
//  Created by Vincent Esche on 5/15/18.
//  Copyright © 2018 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

protocol ViewTheme {
    associatedtype View: ThemableView
    // Theme all views through appearance proxy
    func theme(_ klass: View.Type)
}

protocol ThemableView: UIAppearance {}

extension ThemableView {
    static func apply<Theme: ViewTheme>(theme: Theme) where Theme.View == Self {
        theme.theme(self)
    }
}
