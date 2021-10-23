// LibraryViewLayout.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class LibraryViewLayout {
    enum Section: Int {
        case movies
    }

    // MARK: - Methods

    func makeLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { section, environment -> NSCollectionLayoutSection? in
            switch Section(rawValue: section) {
            case .movies: return self.makeMoviesContainerLayout(with: environment)
            default: return nil
            }
        }
    }
}

// MARK: - Private factory methods

private extension LibraryViewLayout {
    func makeMoviesContainerLayout(with _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let movieItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        movieItem.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let settingGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(296)
            ),
            subitem: movieItem,
            count: 2
        )
        settingGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let section = NSCollectionLayoutSection(group: settingGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        return section
    }
}
