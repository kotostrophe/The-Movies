// LibraryItemsService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
import UIKit

protocol LibraryItemsServiceProtocol: AnyObject {}

final class LibraryItemsService: LibraryItemsServiceProtocol {
    // MARK: - Properties

    // MARK: - Initializers

    // MARK: - Methods

    func makeMovieItem(movie: Movie) {
//        let viewModel = LibraryMovieItemViewModel(movie: movie)
//        let view =
    }
}

extension LibraryItemsService: ReusableContainerDataSource {
    func registerObjects(to container: ReusableContainerProtocol) {}

    func dequeueObject(for conatiner: ReusableContainerProtocol, by indexPath: IndexPath) -> ReusableObjectProtocol {
        conatiner.dequeue(cell: UITableViewCell.self, for: indexPath)
    }
}
