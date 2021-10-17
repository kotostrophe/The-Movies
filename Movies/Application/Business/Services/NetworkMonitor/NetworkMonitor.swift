// NetworkMonitor.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
import Network

protocol NetworkServiceDelegate: AnyObject {
    func networkMonitor(_ networkMonitor: NetworkMonitorProtocol, didUpdate status: NWPath.Status)
}

protocol NetworkMonitorProtocol: AnyObject {
    var lastPathStatus: NWPath.Status? { get }
    var isSatisfied: Bool { get }

    var delegate: NetworkServiceDelegate? { get set }

    func start()
    func stop()
}

final class NetworkMonitor: NetworkMonitorProtocol {
    // MARK: - Properties

    private let monitor: NWPathMonitor
    private let queue: DispatchQueue

    var lastPathStatus: NWPath.Status?

    var isSatisfied: Bool {
        lastPathStatus == .satisfied
    }

    weak var delegate: NetworkServiceDelegate?

    // MARK: - Initializer

    init(queue: DispatchQueue = .global()) {
        self.queue = queue
        monitor = NWPathMonitor()
    }

    // MARK: - Methods

    func start() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            self.lastPathStatus = path.status
            self.delegate?.networkMonitor(self, didUpdate: path.status)
        }
    }

    func stop() {
        monitor.cancel()
    }
}

extension NetworkMonitor: Sharable {
    static let shared: NetworkMonitorProtocol = NetworkMonitor(queue: .global())
}
