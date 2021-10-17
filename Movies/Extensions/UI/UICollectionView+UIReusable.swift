// UICollectionView+UIReusable.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

extension UICollectionReusableView {
    enum Kind {
        case header, footer

        var name: String {
            switch self {
            case .header: return UICollectionView.elementKindSectionHeader
            case .footer: return UICollectionView.elementKindSectionFooter
            }
        }
    }
}

extension UICollectionView {
    // MARK: - Register methods

    func register<Cell: UICollectionViewCell>(_ cell: Cell.Type) {
        register(cell, forCellWithReuseIdentifier: cell.identifier)
    }

    func register<Cell: UICollectionViewCell & UIReusable>(_ cell: Cell.Type) {
        register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
    }

    func registerSupplementary<SupplementaryView: UICollectionReusableView>(
        _ supplementaryView: SupplementaryView.Type,
        as kind: UICollectionReusableView.Kind
    ) {
        register(
            supplementaryView,
            forSupplementaryViewOfKind: kind.name,
            withReuseIdentifier: supplementaryView.identifier
        )
    }

    func registerSupplementary<SupplementaryView: UICollectionReusableView & UIReusable>(
        _ supplementaryView: SupplementaryView.Type,
        as kind: UICollectionReusableView.Kind
    ) {
        register(
            supplementaryView.nib,
            forSupplementaryViewOfKind: kind.name,
            withReuseIdentifier: supplementaryView.identifier
        )
    }

    // MARK: - Dequeue methods

    func dequeueCell<Cell: UICollectionViewCell>(_ cell: Cell.Type, for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? Cell
        else { fatalError("Failed to dequeue \(Cell.self) with identifier: \(cell.identifier)") }
        return cell
    }

    func dequeueSupplementary<SupplementaryView: UICollectionReusableView>(
        _ supplementaryView: SupplementaryView.Type,
        for indexPath: IndexPath,
        as kind: UICollectionReusableView.Kind
    ) -> SupplementaryView {
        guard let supplementaryView = dequeueReusableSupplementaryView(
            ofKind: kind.name,
            withReuseIdentifier: supplementaryView.identifier,
            for: indexPath
        ) as? SupplementaryView
        else {
            fatalError("Failed to dequeue \(SupplementaryView.self) with identifier: \(supplementaryView.identifier)")
        }
        return supplementaryView
    }
}
