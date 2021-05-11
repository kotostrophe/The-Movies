// NetworkingRequest.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol NetworkingRequestProtocol {
    var requestModel: NetworkingRequestDataModel { get }
}

/// Describes networking requests
enum NetworkingRequest: NetworkingRequestProtocol {
    case request(
        method: NetworkingRequestMethod,
        route: String,
        headers: [String: String] = [:],
        parameters: [String: String] = [:]
    )

    var requestModel: NetworkingRequestDataModel {
        switch self {
        case let .request(method: method, route: route, headers: headers, parameters: parameters):
            let parameters = method == .get ? parameters : nil
            let body = method == .get ? nil : parameters

            return NetworkingRequestDataModel(
                method: method,
                route: route,
                headers: headers,
                parameters: parameters,
                body: body
            )
        }
    }
}
