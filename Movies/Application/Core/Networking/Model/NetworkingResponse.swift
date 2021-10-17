// NetworkingResponse.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

enum NetworkingResponse<Response: Decodable> {
    case error(Error), data(Response)
}

enum NetworkingRawResponse {
    case error(Error), data(Data)

    // MARK: - Methods

    func decode<Response: Decodable>(_ type: Response.Type, completion: (NetworkingResponse<Response>) -> Void) {
        switch self {
        case let .data(data):
            do {
                let decodedData = try JSONDecoder().decode(type, from: data)
                completion(.data(decodedData))
            } catch {
                completion(.error(error))
            }

        case let .error(error):
            completion(.error(error))
        }
    }
}
