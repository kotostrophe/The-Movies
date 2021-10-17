// DetailsAttributeView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsAttributeView: UIView {
    // MARK: - Public UI properties

    let imageView: UIImageView = .init()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: Appearance.Title.fontSize,
            weight: Appearance.Title.fontWeight
        )
        label.textColor = Appearance.Title.textColor
        return label
    }()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        setViewConstratins()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Constraints

private extension DetailsAttributeView {
    func setViewConstratins() {
        setImageViewConstraints()
        setTitleConstraints()
    }

    func setImageViewConstraints() {
        addSubview(imageView)
        imageView.anchor
            .leftToSuperview(constant: Appearance.padding.left)
            .topToSuperview(constant: Appearance.padding.top)
            .bottomToSuperview(constant: -Appearance.padding.bottom)
            .width(to: imageView.height)
            .activate()
    }

    func setTitleConstraints() {
        addSubview(titleLabel)
        titleLabel.anchor
            .left(to: imageView.right, constant: Appearance.spacing)
            .rightToSuperview(constant: -Appearance.padding.right)
            .topToSuperview(constant: Appearance.padding.top)
            .bottomToSuperview(constant: -Appearance.padding.bottom)
            .activate()
    }
}

// MARK: - Appearance

extension DetailsAttributeView {
    enum Appearance {
        enum Title {
            static let fontSize: CGFloat = 13.0
            static let fontWeight: UIFont.Weight = .regular
            static let textColor: UIColor = .secondaryLabel
        }

        static let spacing: CGFloat = 8.0
        static let padding: UIEdgeInsets = .init(0)
    }
}
