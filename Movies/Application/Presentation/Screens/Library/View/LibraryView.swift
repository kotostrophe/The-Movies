// LibraryView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class LibraryView: UIView {
    // MARK: - Properties

    let toolbarHeight: CGFloat = 64.0
    let collectionViewContentInset: UIEdgeInsets = .init(top: 0, left: 8, bottom: 64 + 8, right: 0)

    // MARK: - UI Properties

    lazy var collectionView = makeCollectionView()
    lazy var toolbarView = makeSegmentedToolbarView()

    // MARK: - Life cycle methods

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground

        _ = collectionView
        _ = toolbarView
    }
}

private extension LibraryView {
    func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        collectionView.backgroundColor = .clear
        collectionView.contentInset.left = collectionViewContentInset.left
        collectionView.contentInset.right = collectionViewContentInset.right
        collectionView.contentInset.top = collectionViewContentInset.top
        collectionView.contentInset.bottom = collectionViewContentInset.bottom
        collectionView.verticalScrollIndicatorInsets.bottom = toolbarView.frame.height

        return collectionView
    }

    func makeSegmentedToolbarView() -> SegmentedScrollableToolbarView {
        let toolbarView = SegmentedScrollableToolbarView()
        addSubview(toolbarView)
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toolbarView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        toolbarView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        toolbarView.heightAnchor.constraint(equalToConstant: toolbarHeight).isActive = true
        toolbarView.scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: toolbarView.heightAnchor)
            .isActive = true
        toolbarView.scrollView.contentLayoutGuide.widthAnchor
            .constraint(greaterThanOrEqualTo: toolbarView.scrollView.frameLayoutGuide.widthAnchor)
            .isActive = true

        toolbarView.scrollView.showsVerticalScrollIndicator = false
        toolbarView.scrollView.showsHorizontalScrollIndicator = false

        return toolbarView
    }
}
