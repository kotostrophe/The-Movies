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

    let model: DetailsModel
    let imageProxyService: ImageProxyServiceProtocol
    let genreProxyService: GenreProxyServiceProtocol
    let coordinator: LibraryCoordinatorProtocol

    // MARK: - Initializer

    init(
        model: DetailsModel,
        imageProxyService: ImageProxyServiceProtocol,
        genreProxyService: GenreProxyServiceProtocol,
        coordinator: LibraryCoordinatorProtocol
    ) {
        self.model = model
        self.imageProxyService = imageProxyService
        self.genreProxyService = genreProxyService
        self.coordinator = coordinator
    }

    // MARK: - Methods

    func setup() {
        didUpdateState?(model)
    }
}
