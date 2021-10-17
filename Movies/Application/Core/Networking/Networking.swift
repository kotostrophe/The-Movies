// Networking.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Describes error from networking
enum NetworkError: Error {
    case somethingWentWrong(URLResponse?)
    case failToPrepareRequest
    case failWithStatus(Int)
}

protocol NetworkingProtocol: AnyObject {
    var environment: NetworkingEnvironment { get }

    func perform(request: NetworkingRequestDataModel, completion: @escaping (NetworkingRawResponse) -> Void)
}

/// Manage networking
final class Networking: NetworkingProtocol {
    // MARK: - Properties

    let environment: NetworkingEnvironment

    // MARK: - Initializer

    init(environment: NetworkingEnvironment) {
        self.environment = environment
    }

    // MARK: - Methods

    func perform(
        request: NetworkingRequestDataModel,
        completion: @escaping (NetworkingRawResponse) -> Void
    ) {
        guard let request = buildRequest(with: request) else {
            completion(.error(NetworkError.failToPrepareRequest))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.error(error))
                return
            }

            if let data = data {
                completion(.data(data))
                return
            }

            completion(.error(NetworkError.somethingWentWrong(response)))
        }
        dataTask.resume()
    }

    // MARK: - Preparation methods

    private func buildRequest(with requestData: NetworkingRequestDataModel) -> URLRequest? {
        guard let url = buildURL(environment, route: requestData.route, parameters: requestData.parameters)
        else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = requestData.method.rawValue
        request.httpBody = requestData.method == .get ? nil : buildBody(requestData.body ?? [:])
        request.allHTTPHeaderFields = requestData.headers
        return request
    }

    private func buildURL(_ enviroment: NetworkingEnvironment, route: String, parameters: [String: String]?) -> URL? {
        guard let enviromentURL = enviroment.url?.absoluteString else { return nil }
        let url = [enviromentURL, route].joined()

        var urlComponents = URLComponents(string: url)
        guard let queries = parameters?.compactMap({ URLQueryItem(name: $0.key, value: $0.value) })
        else { return urlComponents?.url }

        urlComponents?.queryItems = queries
        return urlComponents?.url
    }

    private func buildBody(_ body: [String: Any]) -> Data? {
        try? JSONSerialization.data(withJSONObject: body, options: [])
    }
}

extension Networking: Sharable {
    static let shared: NetworkingProtocol = {
        let environment = NetworkingEnvironment.base
        return Networking(environment: environment)
    }()
}
