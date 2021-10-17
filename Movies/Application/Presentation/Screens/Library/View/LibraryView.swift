// LibraryView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class LibraryView: UIView {
    // MARK: - UI Properties

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = Appearance.contentMargin
        collectionView.verticalScrollIndicatorInsets.bottom = 0
        return collectionView
    }()

    let segmentedControl: SegmentedControl = .init()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    let toolbarView: ToolbarView = .init()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setComponentsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func layoutSubviews() {
        super.layoutSubviews()
        configureComponents()
    }
}

// MARK: - UI Configure methods

private extension LibraryView {
    func configureComponents() {
        configureView()
    }

    func configureView() {
        backgroundColor = .systemBackground
    }
}

// MARK: - UI Setup methods

private extension LibraryView {
    func setComponentsConstraints() {
        setCollectionViewConstraints()
        setToolbarViewConstraints()
        setScrollViewConstraints()
        setSegmentControlConstraints()
    }

    func setCollectionViewConstraints() {
        addSubview(collectionView)
        collectionView.anchor
            .edgesToSuperview()
            .activate()
    }

    func setToolbarViewConstraints() {
        addSubview(toolbarView)
        toolbarView.anchor
            .leftToSuperview()
            .rightToSuperview()
            .bottomToSuperview()
            .activate()
    }

    func setScrollViewConstraints() {
        toolbarView.contentView = scrollView
    }

    func setSegmentControlConstraints() {
        scrollView.addSubview(segmentedControl)

        let scrollViewContent = scrollView.contentLayoutGuide
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(
                equalTo: scrollViewContent.leadingAnchor,
                constant: Appearance.toolbarContentPadding.left
            ),
            segmentedControl.trailingAnchor.constraint(
                equalTo: scrollViewContent.trailingAnchor,
                constant: -Appearance.toolbarContentPadding.right
            ),
            segmentedControl.topAnchor.constraint(
                equalTo: scrollViewContent.topAnchor,
                constant: Appearance.toolbarContentPadding.top
            ),
            segmentedControl.bottomAnchor.constraint(
                equalTo: scrollViewContent.bottomAnchor,
                constant: -Appearance.toolbarContentPadding.bottom
            )
        ])
    }
}

private extension LibraryView {
    enum Appearance {
        static let contentMargin: UIEdgeInsets = .init(top: 0, left: 8, bottom: ToolbarView.height + 8, right: 0)
        static let toolbarContentPadding: UIEdgeInsets = .init(top: 12, left: 16, bottom: 12, right: 16)
    }
}
