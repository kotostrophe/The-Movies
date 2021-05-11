// NetworkingRequestDataModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Contains different request data for constructing network request
struct NetworkingRequestDataModel {
    let method: NetworkingRequestMethod
    let route: String
    let headers: [String: String]
    let parameters: [String: String]?
    let body: [String: Any]?
}
