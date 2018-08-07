// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
