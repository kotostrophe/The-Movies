// DetailsView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsView: UIView {
    // MARK: - UI Properties

    let tableView: UITableView

    // MARK: - Initializer

    required init() {
        tableView = UITableView(frame: .zero, style: .grouped)

        super.init(frame: .zero)
        placeComponents()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func layoutSubviews() {
        super.layoutSubviews()

        setComponents()
        configureComponents()
    }

    // MARK: - UI Place methods

    private func placeComponents() {
        addSubview(tableView)
    }

    // MARK: - UI Setup methods

    private func setComponents() {
        setView()
        setTableViewComponent()
    }

    private func setView() {
        backgroundColor = .systemBackground
    }

    private func setTableViewComponent() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    // MARK: - UI Configure methods

    private func configureComponents() {
        configureTableViewComponent()
    }

    private func configureTableViewComponent() {
        tableView.backgroundColor = .clear
    }
}
