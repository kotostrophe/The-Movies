// Identifiable.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol Identifiable {
    associatedtype IdentifiableType
    static var identifire: IdentifiableType { get }
}
