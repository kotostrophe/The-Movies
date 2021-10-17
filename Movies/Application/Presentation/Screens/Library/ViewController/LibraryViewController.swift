// LibraryViewController.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class LibraryViewController: UIViewController {
    // MARK: - Properties

    let viewModel: LibraryViewModelProtocol

    // MARK: - UI Properties

    var contentView: LibraryView? {
        view as? LibraryView
    }

    // MARK: - Initializer

    required init(viewModel: LibraryViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func loadView() {
        let view = LibraryView()
        view.collectionView.register(LibraryMovieView.self)
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
        configuraViewModelCallbacks()

        viewModel.setup()
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

    private func configuraViewModelCallbacks() {
        viewModel.didUpdateSelectedGenre = { [weak self] _, index in
            guard let self = self else { return }
            self.contentView?.segmentedControl.selectedSegmentIndex = index
        }

        viewModel.didUpdateMovies = { [weak contentView] _ in
            guard let contentView = contentView else { return }
            let offset: CGPoint = {
                let navigationBarHeigth: CGFloat = 196.0
                var offset = contentView.collectionView.contentOffset
                offset.y = -navigationBarHeigth
                return offset
            }()

            contentView.collectionView.reloadData()
            contentView.collectionView.setContentOffset(offset, animated: true)
        }

        viewModel.didUpdateGenres = { [weak self] _ in
            guard let self = self else { return }
            self.contentView?.segmentedControl.reloadData()
        }
    }

    // MARK: - Methods

    private func clearSearchBar() {
        navigationItem.searchController?.searchBar.text = nil
        navigationItem.searchController?.isActive = false
    }
}

extension LibraryViewController: SegmentedControlDelegate {
    func segmentedControl(_: SegmentedControl, didSelectItemAt index: Int) {
        viewModel.performSelectionGenre(at: index)
    }
}

extension LibraryViewController: SegmentedControlDataSource {
    func numberOfItems(segmentedControl _: SegmentedControl) -> Int {
        viewModel.genres.count
    }

    func segmentedControl(_: SegmentedControl, by index: Int) -> String {
        viewModel.genres[safe: index]?.name ?? ""
    }
}

extension LibraryViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        viewModel.movies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(LibraryMovieView.self, for: indexPath)
        guard let movie = viewModel.movies[safe: indexPath.item] else { return cell }
        cell.dataSource = self
        cell.configure(movie: movie)
        return cell
    }
}

extension LibraryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.performSelectionMovie(at: indexPath.item)
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
}

extension LibraryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces) else { return }
        switch query.isEmpty {
        case true:
            guard let selectedGenre = viewModel.selectedGenre else { return }
            viewModel.fetchMovies(genre: selectedGenre)

        case false:
            viewModel.fetchMovies(query: query)
        }
    }
}

extension LibraryViewController: LibraryMovieViewDelegate {
    func libraryMovieView(_ cell: LibraryMovieView, loadImageBy movie: Movie) {
        viewModel.fetchMoviePoster(movie) { [weak cell, movie] data in
            guard let data = data else { return }
            cell?.configureImageView(data, for: movie)
        }
    }
}
