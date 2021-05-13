// LibraryViewModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol LibraryViewModelProtocol: AnyObject {
    var didUpdateMovies: ((_ movis: [Movie]) -> ())? { get set }
    var didUpdateGenres: ((_ genres: [Genre]) -> ())? { get set }
    var didUpdateSelectedGenre: ((_ genre: Genre, _ atIndex: Int) -> ())? { get set }

    var movies: [Movie] { get }
    var genres: [Genre] { get }
    var selectedGenre: Genre? { get }

    func fetchGenres()
    func fetchMovies(genre: Genre?)
    func fetchMovies(query: String)

    func performSelectionGenre(at index: Int)
    func performSelectionMovie(at index: Int)
}

final class LibraryViewModel: LibraryViewModelProtocol {
    // MARK: - Callbacks

    var didUpdateMovies: ((_ movis: [Movie]) -> ())?
    var didUpdateGenres: ((_ genres: [Genre]) -> ())?
    var didUpdateSelectedGenre: ((_ genre: Genre, _ atIndex: Int) -> ())?

    // MARK: - Properties

    var model: LibraryModel
    let networkService: LibraryNetworkServiceProtocol
    let imageProxyService: ImageProxyServiceProtocol
    let genreProxyService: GenreProxyServiceProtocol
    let coordinator: LibraryCoordinatorProtocol

    let cd = LibraryCoreDataService(coreData: CoreData.shared)

    var movies: [Movie] {
        model.movies
    }

    var genres: [Genre] {
        model.genres
    }

    var selectedGenre: Genre? {
        model.selectedGenre
    }

    // MARK: - Initializer

    required init(
        model: LibraryModel,
        networkService: LibraryNetworkServiceProtocol,
        genreProxyService: GenreProxyServiceProtocol,
        imageProxyService: ImageProxyServiceProtocol,
        coordinator: LibraryCoordinatorProtocol
    ) {
        self.model = model
        self.networkService = networkService
        self.genreProxyService = genreProxyService
        self.imageProxyService = imageProxyService
        self.coordinator = coordinator

        cd.fetchMovies(completion: {
            print($0)
        })
    }

    // MARK: - Methods

    func fetchGenres() {
        genreProxyService.getGenres(completion: { [weak self] genres in
            guard let self = self else { return }

            let genres = genres ?? []
            self.model.genres = genres

            DispatchQueue.main.async {
                self.didUpdateGenres?(genres)
            }
        })
    }

    func fetchMovies(genre: Genre?) {
        networkService.fetchMovies(genreId: genre?.id, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.model.movies = movies

                self.cd.save(movies: movies)

                DispatchQueue.main.async {
                    self.didUpdateMovies?(movies)
                }

            case let .failure(error):
                DispatchQueue.main.async {
                    self.coordinator.startErrorAlert(error: error)
                }
            }
        })
    }

    func fetchMovies(query: String) {
        networkService.fetchMovies(query: query, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(movies):
                self.model.movies = movies
                DispatchQueue.main.async {
                    self.didUpdateMovies?(movies)
                }

            case let .failure(error):
                DispatchQueue.main.async {
                    self.coordinator.startErrorAlert(error: error)
                }
            }
        })
    }

    func performSelectionGenre(at index: Int) {
        guard let genre = model.genres[safe: index] else { return }
        model.selectedGenre = genre

        fetchMovies(genre: genre)
        didUpdateSelectedGenre?(genre, index)
    }

    func performSelectionMovie(at index: Int) {
        guard let movie = model.movies[safe: index] else { return }
        coordinator.startDetails(movie: movie)
    }
}
