// LibraryView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class LibraryView: UIView {
    // MARK: - UI Properties

    let collectionView: UICollectionView
    let segmentedControl: SegmentedControl
    let toolbarView: ScrollableToolbarView

    // MARK: - Initializer

    required init() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        toolbarView = ScrollableToolbarView()
        segmentedControl = SegmentedControl()

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

        setComponents()
        configureComponents()
    }

    // MARK: - UI Place methods

    private func placeComponents() {
        addSubview(collectionView)
        addSubview(toolbarView)
        toolbarView.scrollView.addSubview(segmentedControl)
    }

    // MARK: - UI Setup methods

    private func setComponents() {
        setView()
        setCollectionViewComponent()
        setToolbarViewComponent()
        setToolbarSegmentedControlComponent()
    }

    private func setView() {
        backgroundColor = .systemBackground
    }

    private func setCollectionViewComponent() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setToolbarViewComponent() {
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        toolbarView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        toolbarView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        toolbarView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        toolbarView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        toolbarView.scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: toolbarView.heightAnchor)
            .isActive = true
        toolbarView.scrollView.contentLayoutGuide.widthAnchor
            .constraint(greaterThanOrEqualTo: toolbarView.scrollView.frameLayoutGuide.widthAnchor)
            .isActive = true
    }

    private func setToolbarSegmentedControlComponent() {
        let scrollViewContent = toolbarView.scrollView.contentLayoutGuide

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 16)
            .isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor, constant: -16)
            .isActive = true
        segmentedControl.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: 12)
            .isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: -12).isActive = true
    }

    // MARK: - UI Configure methods

    private func configureComponents() {
        configureCollectionViewComponent()
        configureToolbarComponent()
    }

    private func configureCollectionViewComponent() {
        collectionView.backgroundColor = .clear
        collectionView.contentInset.left = 8
        collectionView.contentInset.right = 8
        collectionView.contentInset.bottom = toolbarView.frame.height + 8
        collectionView.verticalScrollIndicatorInsets.bottom = toolbarView.frame.height
    }

    private func configureToolbarComponent() {
        toolbarView.scrollView.showsVerticalScrollIndicator = false
        toolbarView.scrollView.showsHorizontalScrollIndicator = false
    }
}
