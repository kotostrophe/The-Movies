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

    // MARK: - UI Properties

    let collectionView: UICollectionView

    // MARK: - Initializer

    required init() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        super.init(frame: .zero)
        placeComponents()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func layoutSubviews() {
        super.layoutSubviews()

        configureComponents()
    }
}

private extension DetailsHeaderView {
    // MARK: - Place components

    func placeComponents() {
        placeCollectionView()
    }

    func placeCollectionView() {
        addSubview(collectionView)
    }

    // MARK: - Configurate components

    func configureComponents() {
        configureCollectionView()
    }

    func configureCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        collectionView.backgroundColor = .clear
        collectionView.register(DetailsHeaderImageViewCell.self, forCellWithReuseIdentifier: "imageCell")
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension DetailsHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource?.numberOfImages(at: self) ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let imageCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "imageCell",
            for: indexPath
        ) as? DetailsHeaderImageViewCell
        else { fatalError() }
        guard let data = dataSource?.detailsHeaderView(self, imageDataAt: indexPath.item) else { return imageCell }
        imageCell.imageView.image = UIImage(data: data)
        return imageCell
    }
}

extension DetailsHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        frame.size
    }
}
