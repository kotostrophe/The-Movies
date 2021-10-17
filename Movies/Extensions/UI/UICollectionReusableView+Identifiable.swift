// UICollectionReusableView+Identifiable.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

extension UICollectionReusableView: Identifiable {
    static var identifire: String {
        String(describing: self)
    }
}
