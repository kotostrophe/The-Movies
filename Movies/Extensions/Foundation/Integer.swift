// Integer.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

extension Int {
    var toInt16: Int16 {
        Int16(self)
    }

    var toInt64: Int64 {
        Int64(self)
    }
}

extension Int64 {
    var toInt: Int {
        Int(self)
    }
}
