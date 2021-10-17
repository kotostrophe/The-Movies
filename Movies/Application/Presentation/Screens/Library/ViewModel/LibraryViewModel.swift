// LibraryViewModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol LibraryViewModelProtocol: AnyObject {
    var didUpdateMovies: ((_ movis: [Movie]) -> Void)? { get set }
    var didUpdateGenres: ((_ genres: [Genre]) -> Void)? { get set }
    var didUpdateSelectedGenre: ((_ genre: Genre, _ atIndex: Int) -> Void)? { get set }

    var movies: [Movie] { get }
    var genres: [Genre] { get }
    var selectedGenre: Genre? { get }

    func setup()

    func fetchMovies(genre: Genre)
    func fetchMovies(query: String)
    func fetchMoviePoster(_ movie: Movie, completion: @escaping (Data?) -> Void)

    func performSelectionGenre(at index: Int)
    func performSelectionMovie(at index: Int)
}

final class LibraryViewModel: LibraryViewModelProtocol {
    // MARK: - Callbacks

    var didUpdateMovies: ((_ movis: [Movie]) -> Void)?
    var didUpdateGenres: ((_ genres: [Genre]) -> Void)?
    var didUpdateSelectedGenre: ((_ genre: Genre, _ atIndex: Int) -> Void)?

    // MARK: - Properties

    var model: LibraryModel
    let libraryProxyService: LibraryProxyServiceProtocol
    let imageProxyService: ImageProxyServiceProtocol
    let genreProxyService: GenreProxyServiceProtocol
    let coordinator: LibraryCoordinatorProtocol

    let coreDataService = LibraryCoreDataService(coreData: CoreData.shared)

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
        libraryProxyService: LibraryProxyServiceProtocol,
        genreProxyService: GenreProxyServiceProtocol,
        imageProxyService: ImageProxyServiceProtocol,
        coordinator: LibraryCoordinatorProtocol
    ) {
        self.model = model
        self.libraryProxyService = libraryProxyService
        self.genreProxyService = genreProxyService
        self.imageProxyService = imageProxyService
        self.coordinator = coordinator
    }

    // MARK: - Methods

    func setup() {
        genreProxyService.fetchGenres { [weak self] genres in
            guard let self = self else { return }
            switch genres {
            case let .success(genres):
                self.model.genres = genres.sorted(by: { $0.name < $1.name })
                DispatchQueue.main.async {
                    self.didUpdateGenres?(genres)
                    self.performSelectionGenre(at: .zero)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.coordinator.startErrorAlert(error: error)
                }
            }
        }
    }

    func fetchMovies(genre: Genre) {
        libraryProxyService.fetchMovies(genre: genre) { [weak self] result in
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
        }
    }

    func fetchMovies(query: String) {
        libraryProxyService.fetchMovies(query: query) { [weak self] result in
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
        }
    }

    func fetchMoviePoster(_ movie: Movie, completion: @escaping (Data?) -> Void) {
        guard let posterPath = movie.posterPath?.trimLast("/") else { return }
        imageProxyService.getImage(by: posterPath) { data in
            DispatchQueue.main.async {
                completion(data)
            }
        }
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
