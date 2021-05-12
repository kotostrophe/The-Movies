// SegmentedScrollableToolbarView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

///
class SegmentedScrollableToolbarView: ScrollableToolbarView {
    let segmentedControl: SegmentedControl

    // MARK: - Initializer

    required init() {
        segmentedControl = SegmentedControl()

        super.init()
        placeComponents()
    }

    // MARK: - Life cycle methods

    override func layoutSubviews() {
        super.layoutSubviews()

        setComponents()
    }

    // MARK: - UI Place methods

    private func placeComponents() {
        scrollView.addSubview(segmentedControl)
    }

    // MARK: - UI Setup methods

    private func setComponents() {
        setToolbarSegmentedControlComponent()
    }
}

extension SegmentedScrollableToolbarView {
    private func setToolbarSegmentedControlComponent() {
        let scrollViewContent = scrollView.contentLayoutGuide

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.leadingAnchor.constraint(equalTo: scrollViewContent.leadingAnchor, constant: 16)
            .isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: scrollViewContent.trailingAnchor, constant: -16)
            .isActive = true
        segmentedControl.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: 12)
            .isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: -12)
            .isActive = true
    }
}
