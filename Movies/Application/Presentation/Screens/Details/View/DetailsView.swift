// DetailsView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsView: UIView {
    // MARK: - UI Properties

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.tableFooterView = .init()
        return tableView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureComponents()
        setComponentsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func layoutSubviews() {
        super.layoutSubviews()
        configureComponents()
    }
}

// MARK: - UI Configure methods

private extension DetailsView {
    func configureComponents() {
        configureView()
    }

    func configureView() {
        backgroundColor = .systemBackground
    }
}

// MARK: - UI Setup methods

private extension DetailsView {
    func setComponentsConstraints() {
        setCollectionViewConstraints()
    }

    func setCollectionViewConstraints() {
        addSubview(tableView)
        tableView.anchor
            .edgesToSuperview(insets: Appearance.padding)
            .activate()
    }
}

private extension DetailsView {
    enum Appearance {
        static let padding: UIEdgeInsets = .init(0)
    }
}
