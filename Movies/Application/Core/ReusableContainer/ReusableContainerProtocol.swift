// ReusableContainerProtocol.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol ReusableContainerDataSource: AnyObject {
    func registerObjects(to container: ReusableContainerProtocol)
    func dequeueObject(for conatiner: ReusableContainerProtocol, by indexPath: IndexPath) -> ReusableObjectProtocol
}

protocol ReusableContainerProtocol: AnyObject {
    func register(cell: UIIdentifiable.Type)
    func register(cell: (UIIdentifiable & UINibable).Type)
    func dequeue(cell: UIIdentifiable.Type, for indexPath: IndexPath) -> ReusableObjectProtocol
}

extension UICollectionView: ReusableContainerProtocol {
    func register(cell: UIIdentifiable.Type) {
        register(cell, forCellWithReuseIdentifier: cell.identifier)
    }

    func register(cell: (UIIdentifiable & UINibable).Type) {
        let nib = UINib(nibName: cell.identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cell.identifier)
    }

    func dequeue(cell: UIIdentifiable.Type, for indexPath: IndexPath) -> ReusableObjectProtocol {
        dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath)
    }
}

extension UITableView: ReusableContainerProtocol {
    func register(cell: UIIdentifiable.Type) {
        register(cell, forCellReuseIdentifier: cell.identifier)
    }

    func register(cell: (UIIdentifiable & UINibable).Type) {
        let nib = UINib(nibName: cell.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }

    func dequeue(cell: UIIdentifiable.Type, for indexPath: IndexPath) -> ReusableObjectProtocol {
        dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath)
    }
}
