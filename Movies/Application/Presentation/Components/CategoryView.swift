// CategoryView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class CategoryView: UIView {
    // MARK: - UI Properties

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Appearance.spacing
        return stackView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: Appearance.Title.fontSize,
            weight: Appearance.Title.fontWeight
        )
        label.textColor = Appearance.Title.textColor
        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: Appearance.Subtitle.fontSize,
            weight: Appearance.Subtitle.fontWeight
        )
        label.numberOfLines = 0
        label.textColor = Appearance.Subtitle.textColor
        return label
    }()

    // MARK: - Initializer

    required init() {
        super.init(frame: .zero)

        setComponentsConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Setup methods

private extension CategoryView {
    func setComponentsConstraints() {
        setStackViewConstraints()
    }

    func setStackViewConstraints() {
        addSubview(stackView)
        stackView.set(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.anchor
            .edgesToSuperview()
            .activate()
    }
}

// MARK: - Appearance

private extension CategoryView {
    enum Appearance {
        enum Title {
            static let fontSize: CGFloat = 19.0
            static let fontWeight: UIFont.Weight = .semibold
            static let textColor: UIColor = .label
        }

        enum Subtitle {
            static let fontSize: CGFloat = 13.0
            static let fontWeight: UIFont.Weight = .regular
            static let textColor: UIColor = .secondaryLabel
        }

        static let spacing: CGFloat = 4.0
    }
}
