// Sharable.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol Sharable {
    associatedtype SharableProtocol
    static var shared: SharableProtocol { get }
}
