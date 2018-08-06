//
//  Gestalt.swift
//  Gestalt
//
//  Created by Vincent Esche on 7/3/17.
//  Copyright © 2017 Vincent Esche. All rights reserved.
//

import Foundation

/// Tagging protocol for Gestalt themes
public protocol Theme {}

/// Disposable pattern
public class Disposable {
    private let disposal: () -> ()

    init(disposal: @escaping () -> ()) {
        self.disposal = disposal
    }

    deinit {
        self.disposal()
    }
}
