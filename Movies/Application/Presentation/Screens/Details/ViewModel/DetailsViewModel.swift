// DetailsViewModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol DetailsViewModelProtocol: AnyObject {
    var didSetupWithMovie: ((_ movie: Movie) -> ())? { get set }
    var didFetchGenres: ((_ genres: [Genre]) -> ())? { get set }
    var didFetchPosters: ((_ posters: [Data]) -> ())? { get set }

    var components: [DetailsComponent] { get }
    var posters: [Data] { get }
    var genres: [Genre] { get }
    var movie: Movie { get }

    func setup()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Callbacks

    var didSetupWithMovie: ((_ movie: Movie) -> ())?
    var didFetchGenres: ((_ genres: [Genre]) -> ())?
    var didFetchPosters: ((_ posters: [Data]) -> ())?

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
        fetchPostersPath()
    }

    func fetchGenres() {
        genreProxyService.fetchGenres(completion: { [weak self] genres in
            guard let self = self else { return }
            guard case let .success(genres) = genres else { return }

            let filteredGenres = genres.filter { self.model.movie.genres.contains($0.id) }
            self.model.genres = filteredGenres

            DispatchQueue.main.async {
                self.didFetchGenres?(filteredGenres)
            }
        })
    }

    func fetchPostersPath() {
        networkService.fetchPosters(for: model.movie, completion: { [weak self] result in
            guard let self = self else { return }
            guard case let .success(posters) = result else { return }

            self.model.posters = Array(posters.prefix(3))
            self.fetchPostersData()
        })
    }

    func fetchPostersData() {
        model.posters.forEach { poster in
            guard let posterName = poster.filePath.trimLast("/") else { return }

            posterDispatchGroup.enter()
            imageProxyService.getImage(by: posterName, completion: { [weak self] data in
                guard let self = self else { return }

                if let data = data {
                    self.posterData.append(data)
                }
                self.posterDispatchGroup.leave()
            })
        }

        posterDispatchGroup.notify(queue: .main, execute: {
            self.didFetchPosters?(self.posterData)
        })
    }
}
