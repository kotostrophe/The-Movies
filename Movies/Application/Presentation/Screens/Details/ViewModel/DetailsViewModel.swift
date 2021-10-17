// DetailsViewModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol DetailsViewModelProtocol: AnyObject {
    var didSetupWithMovie: ((_ movie: Movie) -> Void)? { get set }
    var didFetchGenres: ((_ genres: [Genre]) -> Void)? { get set }
    var didFetchPosters: ((_ posters: [Data]) -> Void)? { get set }

    var components: [DetailsComponent] { get }
    var posters: [Data] { get }
    var genres: [Genre] { get }
    var movie: Movie { get }

    func setup()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Callbacks

    var didSetupWithMovie: ((_ movie: Movie) -> Void)?
    var didFetchGenres: ((_ genres: [Genre]) -> Void)?
    var didFetchPosters: ((_ posters: [Data]) -> Void)?

    // MARK: - Properties

    let posterDispatchGroup: DispatchGroup

    var model: DetailsModel
    let networkService: DetailsNetworkServiceProtocol
    let imageProxyService: ImageProxyServiceProtocol
    let genreProxyService: GenreProxyServiceProtocol
    let coordinator: LibraryCoordinatorProtocol

    var posterData: [Data] = []

    var components: [DetailsComponent] {
        model.components
    }

    var posters: [Data] {
        posterData
    }

    var genres: [Genre] {
        model.genres
    }

    var movie: Movie {
        model.movie
    }

    // MARK: - Initializer

    init(
        model: DetailsModel,
        networkService: DetailsNetworkServiceProtocol,
        imageProxyService: ImageProxyServiceProtocol,
        genreProxyService: GenreProxyServiceProtocol,
        coordinator: LibraryCoordinatorProtocol
    ) {
        posterDispatchGroup = DispatchGroup()
        self.model = model
        self.networkService = networkService
        self.imageProxyService = imageProxyService
        self.genreProxyService = genreProxyService
        self.coordinator = coordinator
    }

    // MARK: - Methods

    func setup() {
        didSetupWithMovie?(model.movie)

        fetchGenres()
        fetchPosters()
    }

    func fetchGenres() {
        genreProxyService.fetchGenres { [weak self] genres in
            guard let self = self else { return }
            guard case let .success(genres) = genres else { return }

            let filteredGenres = genres.filter { self.model.movie.genres.contains($0.id) }
            self.model.genres = filteredGenres

            DispatchQueue.main.async {
                self.didFetchGenres?(filteredGenres)
            }
        }
    }

    func fetchPosters() {
        networkService.fetchPosters(for: model.movie) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(posters):
                self.model.posters = Array(posters.prefix(3))
                self.fetchPostersData()

            case .failure:
                guard let moviePoster = self.movie.posterPath?.trimLast("/") else { return }
                self.imageProxyService.getImage(by: moviePoster, completion: { [weak self] data in
                    guard let data = data else { return }
                    self?.posterData = [data]

                    DispatchQueue.main.async {
                        self?.didFetchPosters?([data])
                    }
                })
            }
        }
    }

    func fetchPostersData() {
        model.posters.forEach { poster in
            guard let posterName = poster.filePath.trimLast("/") else { return }

            posterDispatchGroup.enter()
            imageProxyService.getImage(by: posterName) { [weak self] data in
                guard let self = self else { return }

                if let data = data {
                    self.posterData.append(data)
                }
                self.posterDispatchGroup.leave()
            }
        }

        posterDispatchGroup.notify(queue: .main) {
            self.didFetchPosters?(self.posterData)
        }
    }
}
