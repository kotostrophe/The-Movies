// Collection+SafeSubscript.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
