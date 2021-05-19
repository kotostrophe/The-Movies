// NetworkingRequest.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Describes networking requests
class NetworkingRequest {
    static func request(
        method: NetworkingRequestMethod,
        route: String,
        headers: [String: String] = [:],
        parameters: [String: String] = [:]
    ) -> NetworkingRequestDataModel {
        print(parameters)

        return NetworkingRequestDataModel(
            method: method,
            route: route,
            headers: headers,
            parameters: method == .get ? parameters : nil,
            body: method == .get ? nil : parameters
        )
    }

    static func request<Parameters: Encodable>(
        method: NetworkingRequestMethod,
        route: String,
        headers: [String: String] = [:],
        parameters: Parameters
    ) -> NetworkingRequestDataModel {
        let data: [String: String]? = {
            guard let dataParameters = try? JSONEncoder().encode(parameters) else { return [:] }
            return try? JSONSerialization.jsonObject(with: dataParameters, options: []) as? [String: String]
        }()

        return NetworkingRequest.request(method: method, route: route, headers: headers, parameters: data ?? [:])
    }
}
