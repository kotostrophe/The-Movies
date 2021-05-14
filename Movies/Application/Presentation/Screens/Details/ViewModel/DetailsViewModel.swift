// DetailsViewModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol DetailsViewModelProtocol: AnyObject {
    var didUpdateState: ((_ model: DetailsModel) -> ())? { get set }

    func setup()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Callbacks

    var didUpdateState: ((_ model: DetailsModel) -> ())?

    // MARK: - Properties

    let movie: Movie
    let components: [DetailsComponent]
    var genres: [Genre]

    let model: DetailsModel
    let imageProxyService: ImageProxyServiceProtocol
    let genreProxyService: GenreProxyServiceProtocol
    let coordinator: LibraryCoordinatorProtocol

    // MARK: - Initializer

    init(
        movie: Movie,
        components: [DetailsComponent],
        genres: [Genre],
        model: DetailsModel,
        imageProxyService: ImageProxyServiceProtocol,
        genreProxyService: GenreProxyServiceProtocol,
        coordinator: LibraryCoordinatorProtocol
    ) {
        self.movie = movie
        self.components = components
        self.genres = genres
        self.model = model
        self.imageProxyService = imageProxyService
        self.genreProxyService = genreProxyService
        self.coordinator = coordinator
    }

    // MARK: - Methods

    func setup() {
        didUpdateState?(.loading)

        genreProxyService.fetchGenres(completion: { [weak self] genres in
            guard let self = self else { return }

            switch genres {
            case let .success(genres):
                let filteredGenres = genres.filter { self.movie.genres.contains($0.id) }
                let data = DetailsModel.Data(movie: self.movie, genres: filteredGenres, components: self.components)

                self.genres = filteredGenres
                DispatchQueue.main.async {
                    self.didUpdateState?(.data(data))
                }

            case let .failure(error):
                DispatchQueue.main.async {
                    self.didUpdateState?(.error(error))
                }
            }
        })
    }
}
