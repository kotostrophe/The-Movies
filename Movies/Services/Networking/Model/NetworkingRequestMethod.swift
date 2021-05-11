// NetworkingRequestMethod.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Describe types of methods with which network request must execute
enum NetworkingRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
