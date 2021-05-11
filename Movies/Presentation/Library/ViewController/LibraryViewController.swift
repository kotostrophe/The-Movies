// LibraryViewController.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class LibraryViewController: UIViewController {
    // MARK: - Properties

    let libraryNetworkService: LibraryNetworkServiceProtocol
    let libraryImageProxyService: ImageProxyServiceProtocol
    let libraryGenreProxyService: GenreProxyServiceProtocol
    let libraryCoordinator: LibraryFlow
    var libraryModel: LibraryModel

    // MARK: - UI Properties

    var contentView: LibraryView? {
        view as? LibraryView
    }

    // MARK: - Initializer

    required init(
        model: LibraryModel,
        networkService: LibraryNetworkServiceProtocol,
        genreProxyService: GenreProxyServiceProtocol,
        imageProxyService: ImageProxyServiceProtocol,
        coordinator: LibraryFlow
    ) {
        libraryModel = model
        libraryNetworkService = networkService
        libraryGenreProxyService = genreProxyService
        libraryImageProxyService = imageProxyService
        libraryCoordinator = coordinator

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func loadView() {
        let view = LibraryView()
        view.collectionView.register(LibraryMovieView.self, forCellWithReuseIdentifier: LibraryMovieView.identifire)
        view.collectionView.dataSource = self
        view.collectionView.delegate = self
        view.segmentedControl.dataSource = self
        view.segmentedControl.delegate = self

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Library"

        configureNavigationBar()
        configureSearchBar()

        fetchGenres()
        fetchMovies(genre: nil)
    }

    // MARK: - Configuration methods

    private func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
    }

    private func configureSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search movies, cartoons and other"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Methods

    private func clearSearchBar() {
        navigationItem.searchController?.searchBar.text = nil
        navigationItem.searchController?.isActive = false
    }

    private func scrollToTop() {
        contentView?.collectionView.scrollToItem(at: .init(item: 0, section: 0), at: .top, animated: true)
    }

    // MARK: - Networking methods

    private func fetchGenres() {
        libraryGenreProxyService.getGenres(completion: { [weak self] genres in
            self?.libraryModel.genres = genres ?? []

            DispatchQueue.main.async {
                self?.contentView?.segmentedControl.reloadData()
            }
        })
    }

    private func fetchMovies(genre: Genre?) {
        libraryNetworkService.fetchMovies(genreId: genre?.id, completion: { [weak self] result in
            switch result {
            case let .success(movies):
                self?.libraryModel.movies = movies

                DispatchQueue.main.async {
                    self?.contentView?.collectionView.reloadData()
                }

            case let .failure(error):
                DispatchQueue.main.async {
                    self?.libraryCoordinator.startErrorAlert(error: error)
                }
            }
        })
    }

    private func fetchMovies(query: String) {
        libraryNetworkService.fetchMovies(query: query, completion: { [weak self] result in
            switch result {
            case let .success(movies):
                self?.libraryModel.movies = movies

                DispatchQueue.main.async {
                    self?.contentView?.collectionView.reloadData()
                }

            case let .failure(error):
                DispatchQueue.main.async {
                    self?.libraryCoordinator.startErrorAlert(error: error)
                }
            }
        })
    }
}

extension LibraryViewController: SegmentedControlDelegate {
    func segmentedControl(_: SegmentedControl, didSelectItemAt index: Int) {
        clearSearchBar()
        scrollToTop()

        let genre = libraryModel.genres[index]
        libraryModel.selectedGenre = genre
        fetchMovies(genre: genre)
    }
}

extension LibraryViewController: SegmentedControlDataSource {
    func numberOfItems(segmentedControl _: SegmentedControl) -> Int {
        libraryModel.genres.count
    }

    func segmentedControl(_: SegmentedControl, by index: Int) -> String {
        libraryModel.genres[index].name
    }
}

extension LibraryViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        libraryModel.movies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LibraryMovieView.identifire,
            for: indexPath
        ) as? LibraryMovieView else { return .init() }

        let movie = libraryModel.movies[indexPath.item]
        let model = LibraryMovieModel(movie: movie)
        let imageProxy = ImageProxyService.shared

        movieCell.configure(with: model, imageProxy: imageProxy)
        return movieCell
    }
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = libraryModel.movies[indexPath.item]
        libraryCoordinator.startDetails(movie: movie)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt _: IndexPath
    ) -> CGSize {
        let horisontalInset = collectionView.contentInset.left + collectionView.contentInset.right
        let width = (collectionView.bounds.width - horisontalInset) / 2
        return CGSize(width: width, height: width * 1.5)
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumLineSpacingForSectionAt _: Int
    ) -> CGFloat {
        0
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt _: Int
    ) -> CGFloat {
        0
    }
}

extension LibraryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        let selectedGenre = libraryModel.selectedGenre

        switch query.isEmpty {
        case true: fetchMovies(genre: selectedGenre)
        case false: fetchMovies(query: query)
        }
    }
}
