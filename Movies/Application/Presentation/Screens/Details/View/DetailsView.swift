// DetailsView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsView: UIView {
    // MARK: - UI Properties

    lazy var tableView: UITableView = {
        let tableView = makeTableView()
        tableView.tableFooterView = .init()
        return tableView
    }()

    // MARK: - Life cycle methods

    override func layoutSubviews() {
        super.layoutSubviews()

        backgroundColor = .systemBackground
    }
}

extension DetailsView {
    func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        return tableView
    }
}
