// LibraryMovieItemViewModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol LibraryMovieItemViewModelProtocol: AnyObject {
    var didLoadPosterData: ((Data) -> Void)? { get set }

    var movie: Movie { get }
}

final class LibraryMovieItemViewModel: LibraryMovieItemViewModelProtocol {
    // MARK: - Callbacks

    var didLoadPosterData: ((Data) -> Void)?

    // MARK: - Properties

    let movie: Movie

    // MARK: - Initializers

    init(movie: Movie) {
        self.movie = movie
    }

    // MARK: - Methods
}
