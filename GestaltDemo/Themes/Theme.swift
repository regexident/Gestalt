//
//  Theme.swift
//  Gestalt
//
//  Created by Vincent Esche on 7/3/17.
//  Copyright © 2017 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

struct NativeTheme: Theme {
    let navigationBar: NavigationBarTheme
    let textfield: TextFieldTheme
    let segmentedControl: SegmentedControlTheme
    let activityIndicator: ActivityIndicatorViewTheme
    let stepper: StepperTheme
    let `switch`: SwitchTheme
    let slider: SliderTheme
    let button: ButtonTheme

    init(palette: Palette) {
        self.navigationBar = .init(palette: palette)
        self.textfield = .init(palette: palette)
        self.segmentedControl = .init(palette: palette)
        self.activityIndicator = .init(palette: palette)
        self.stepper = .init(palette: palette)
        self.switch = .init(palette: palette)
        self.slider = .init(palette: palette)
        self.button = .init(palette: palette)
    }
}

struct CustomTheme: Theme {
    let stageDesign: StageDesignViewTheme
    let demo: DemoViewTheme
    
    init(palette: Palette) {
        self.stageDesign = .init(palette: palette)
        self.demo = .init(palette: palette)
    }
}

struct ApplicationTheme: Theme {
    let native: NativeTheme
    let custom: CustomTheme

    static var `default`: ApplicationTheme {
        return .light
    }

    static let light: ApplicationTheme = .init(palette: .light)
    static let dark: ApplicationTheme = .init(palette: .dark)
    static let debug: ApplicationTheme = .init(palette: .debug)

    init(palette: Palette) {
        self.native = .init(palette: palette)
        self.custom = .init(palette: palette)
    }
}
