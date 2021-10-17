// UITableView+UIReusable.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

extension UITableView {
    // MARK: - Register methods

    func registerCell<Cell: UITableViewCell>(_ cell: Cell.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }

    func registerCell<Cell: UITableViewCell & UIReusable>(_ cell: Cell.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }

    func registerSupplementary<SupplementaryView: UITableViewHeaderFooterView>(
        _ supplementaryView: SupplementaryView.Type
    ) {
        register(supplementaryView, forHeaderFooterViewReuseIdentifier: supplementaryView.identifier)
    }

    func registerSupplementary<SupplementaryView: UITableViewHeaderFooterView & UIReusable>(
        _ supplementaryView: SupplementaryView.Type
    ) {
        register(supplementaryView.nib, forHeaderFooterViewReuseIdentifier: supplementaryView.identifier)
    }

    // MARK: - Dequeue methods

    func dequeueCell<Cell: UITableViewCell>(_ cell: Cell.Type) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: cell.identifier) as? Cell
        else { fatalError("Failed to dequeue \(Cell.self) with identifier: \(cell.identifier)") }
        return cell
    }

    func dequeueCell<Cell: UITableViewCell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? Cell
        else { fatalError("Failed to dequeue \(Cell.self) with identifier: \(cell.identifier)") }
        return cell
    }

    func dequeueSupplementary<SupplementaryView: UITableViewHeaderFooterView>(
        _ supplementaryView: SupplementaryView
            .Type
    ) -> SupplementaryView {
        guard let cell = dequeueReusableHeaderFooterView(
            withIdentifier: supplementaryView.identifier
        ) as? SupplementaryView
        else {
            fatalError("Failed to dequeue \(SupplementaryView.self) with identifier: \(supplementaryView.identifier)")
        }
        return cell
    }
}
