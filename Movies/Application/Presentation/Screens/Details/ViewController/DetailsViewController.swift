// DetailsViewController.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsViewController: UIViewController {
    // MARK: - Properties

    let viewModel: DetailsViewModelProtocol

    // MARK: - UI Properties

    var contentView: DetailsView? {
        view as? DetailsView
    }

    // MARK: - Initializer

    required init(
        viewModel: DetailsViewModelProtocol
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func loadView() {
        let view = DetailsView()
        view.tableView.estimatedRowHeight = 98
        view.tableView.rowHeight = UITableView.automaticDimension

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCallbacks()
        viewModel.setup()
    }

    // MARK: - Configuration methods

    private func configureCallbacks() {
        viewModel.didUpdateState = { [weak contentView] state in
            contentView?.state = state
        }
    }
}
