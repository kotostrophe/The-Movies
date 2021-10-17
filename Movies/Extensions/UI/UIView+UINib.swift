// UIView+UINib.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

extension UIView {
    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
}
