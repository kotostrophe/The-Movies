// DispatchQueue+SafeMain.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

extension DispatchQueue {
    static func safeMain<T>(work: () throws -> T) rethrows -> T {
        guard Thread.isMainThread
        else { return try main.sync(execute: work) }
        return try work()
    }
}
