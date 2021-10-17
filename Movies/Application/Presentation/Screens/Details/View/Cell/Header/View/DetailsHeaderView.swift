// DetailsHeaderView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol DetailsHeaderViewDataSource: AnyObject {
    func numberOfImages(at detailsHeaderView: DetailsHeaderView) -> Int
    func detailsHeaderView(_ detailsHeaderView: DetailsHeaderView, imageDataAt index: Int) -> Data
}

final class DetailsHeaderView: UIView {
    // MARK: - Properties

    weak var dataSource: DetailsHeaderViewDataSource?

    // MARK: - Private UI properties

    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.register(DetailsHeaderImageViewCell.self)
        collectionView.isPagingEnabled = true
        return collectionView
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension DetailsHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource?.numberOfImages(at: self) ?? .zero
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(DetailsHeaderImageViewCell.self, for: indexPath)
        guard let data = dataSource?.detailsHeaderView(self, imageDataAt: indexPath.item) else { return cell }
        cell.imageView.image = UIImage(data: data)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DetailsHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        frame.size
    }
}

// MARK: - Configuration methods

private extension DetailsHeaderView {
    func configureView() {
        configureCollectionView()
    }

    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - Constratins

private extension DetailsHeaderView {
    func setConstraints() {
        setCollectionViewConstraints()
    }

    func setCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.anchor
            .edgesToSuperview(insets: Appearance.padding)
            .activate()
    }
}

extension DetailsHeaderView {
    enum Appearance {
        static let padding: UIEdgeInsets = .init(.zero)
    }
}
