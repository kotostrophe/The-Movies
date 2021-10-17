// UIIdentifiable.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol UIIdentifiable where Self: UIResponder {
    static var identifier: String { get }
}

extension UIIdentifiable {
    static var identifier: String {
        let className = String(describing: self)
        guard className.contains("<") else { return className }
        return className.components(separatedBy: "<").first ?? className
    }
}
