//
//  Theme.swift
//  Gestalt
//
//  Created by Vincent Esche on 7/3/17.
//  Copyright © 2017 Vincent Esche. All rights reserved.
//

import UIKit

import Gestalt

struct DefaultTheme {
    let navigationBar: NavigationBarTheme
    let textfield: TextFieldTheme
    let segmentedControl: SegmentedControlTheme
    let activityIndicator: ActivityIndicatorViewTheme
    let stepper: StepperTheme
    let `switch`: SwitchTheme
    let slider: SliderTheme
    let button: ButtonTheme
}

struct CustomTheme {
    let stageDesign: StageDesignViewTheme
    let demo: DemoViewTheme
    

    init(palette: Palette) {
        self.stageDesign = .init(palette: palette)
        self.demo = .init(palette: palette)
    }
}

struct Theme: ThemeProtocol {
    let `default`: DefaultTheme
    let custom: CustomTheme

    static var `default`: Theme {
        return Theme.light
    }

    static let light: Theme = .init(palette: .light)
    static let dark: Theme = .init(palette: .dark)
    static let debug: Theme = .init(palette: .debug)
}

extension Theme {
    init(palette: Palette) {
        self.init(
            default: .init(
                navigationBar: .init(palette: palette),
                textfield: .init(palette: palette),
                segmentedControl: .init(palette: palette),
                activityIndicator: .init(palette: palette),
                stepper: .init(palette: palette),
                switch: .init(palette: palette),
                slider: .init(palette: palette),
                button: .init(palette: palette)
            ),
            custom: .init(palette: palette)
        )
    }
}
