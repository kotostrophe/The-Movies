// UIStackView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

extension UIStackView {
    func add(arrangedSubview: UIView) {
        addArrangedSubview(arrangedSubview)
    }

    func add(arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach(add(arrangedSubview:))
    }

    func remove(arrangedSubview: UIView) {
        guard arrangedSubviews.contains(arrangedSubview) else { return }
        removeArrangedSubview(arrangedSubview)
        arrangedSubview.removeFromSuperview()
    }

    func remove(arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach(remove(arrangedSubview:))
    }

    func remove(first amountOfElements: Int) {
        arrangedSubviews.prefix(amountOfElements).forEach(remove(arrangedSubview:))
    }

    func remove(last amountOfElements: Int) {
        arrangedSubviews.suffix(amountOfElements).forEach(remove(arrangedSubview:))
    }

    func clear() {
        remove(arrangedSubviews: arrangedSubviews)
    }

    func set(arrangedSubviews: [UIView]) {
        clear()
        add(arrangedSubviews: arrangedSubviews)
    }
}
