// UINibable.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol UINibable where Self: UIResponder {
    func configureNib()
}

extension UINibable where Self: UIView {
    // MARK: - Configuration

    func configureNib() {
        guard let contentView = Self.nib.instantiate(withOwner: self).first as? UIView else { return }

        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
