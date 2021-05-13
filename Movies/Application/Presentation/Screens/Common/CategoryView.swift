// CategoryView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class CategoryView: UIView {
    // MARK: - UI Properties

    private lazy var stackView = makeStacKView()
    lazy var titleLabel = makeTitleLabel()
    lazy var descriptionLabel = makeDescriptionLabel()

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)

        _ = stackView
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        _ = stackView
    }
}

extension CategoryView {
    func makeStacKView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }

    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        return label
    }

    func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }
}
