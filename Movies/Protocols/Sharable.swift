// Sharable.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol Shareble {
    associatedtype SharableProtocol
    static var shared: SharableProtocol { get }
}
