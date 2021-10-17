// UIEdgeInsets.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

extension UIEdgeInsets {
    // MARK: - Properties

    var horizontal: CGFloat { left + right }

    var vertical: CGFloat { top + bottom }

    // MARK: - Initialziers

    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    init(_ value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
}
