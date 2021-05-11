// ScrollableToolbarView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

/// UI component with blurred backbground with scrollView in the hierarchy. Should be used on the bottom of the screen
class ScrollableToolbarView: ToolbarView {
    // MARK: - Properties

    let scrollView: UIScrollView

    // MARK: - Initializer

    required init() {
        scrollView = UIScrollView()

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
        visualEffectView.contentView.addSubview(scrollView)
    }

    // MARK: - UI Setup methods

    private func setComponents() {
        setScrollViewComponent()
    }

    private func setScrollViewComponent() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: visualEffectView.contentView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: visualEffectView.contentView.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: visualEffectView.contentView.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: visualEffectView.contentView.bottomAnchor).isActive = true
    }
}
