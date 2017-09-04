//
//  GestaltTests.swift
//  GestaltTests
//
//  Created by Vincent Esche on 7/3/17.
//  Copyright © 2017 Vincent Esche. All rights reserved.
//

import XCTest
@testable import Gestalt

struct DummyTheme: ThemeProtocol {
    let isCustom: Bool

    static let `default`: DummyTheme = .init(isCustom: false)
    static let custom: DummyTheme = .init(isCustom: true)
}

class GestaltTests: XCTestCase {
        
    func testGestalt() {
        let manager = ThemeManager()
        manager.theme = DummyTheme.default

        let expectation = self.expectation(description: "Should apply theme")

        manager.apply(theme: DummyTheme.self, to: self, animated: false) { themeable, theme in
            if theme.isCustom {
                expectation.fulfill()
            }
        }

        manager.theme = DummyTheme.custom

        self.waitForExpectations(timeout: 1.0)
    }
    
}
