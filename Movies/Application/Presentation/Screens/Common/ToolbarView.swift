// ToolbarView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

/// UI component with blurred backbground. Should be used on the bottom of the screen
class ToolbarView: UIView {
    // MARK: - Properties

    let visualEffectView: UIVisualEffectView
    let separatorView: UIView

    // MARK: - Initializer

    required init() {
        visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        separatorView = UIView()

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
        addSubview(visualEffectView)
        visualEffectView.contentView.addSubview(separatorView)
    }

    // MARK: - UI Setup methods

    private func setComponents() {
        setCollectionViewComponent()
        setToolbarSeparatorViewComponent()
    }

    private func setCollectionViewComponent() {
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    private func setToolbarSeparatorViewComponent() {
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: visualEffectView.contentView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: visualEffectView.contentView.trailingAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: visualEffectView.contentView.topAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }

    // MARK: - UI Configure methods

    private func configureComponents() {
        configureSeparatorViewComponent()
    }

    private func configureSeparatorViewComponent() {
        separatorView.backgroundColor = .opaqueSeparator
        separatorView.alpha = 0.3
    }
}
