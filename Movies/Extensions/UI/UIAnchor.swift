// UIAnchor.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

extension UIView {
    var anchor: Anchor { Anchor(view: self) }

    var top: NSLayoutAnchor<NSLayoutYAxisAnchor> { topAnchor }
    var left: NSLayoutAnchor<NSLayoutXAxisAnchor> { leftAnchor }
    var bottom: NSLayoutAnchor<NSLayoutYAxisAnchor> { bottomAnchor }
    var right: NSLayoutAnchor<NSLayoutXAxisAnchor> { rightAnchor }
    var height: NSLayoutDimension { heightAnchor }
    var width: NSLayoutDimension { widthAnchor }
    var centerX: NSLayoutXAxisAnchor { centerXAnchor }
    var centerY: NSLayoutYAxisAnchor { centerYAnchor }
}

///
struct Anchor {
    // MARK: - Properties

    let view: UIView
    let top: NSLayoutConstraint?
    let left: NSLayoutConstraint?
    let bottom: NSLayoutConstraint?
    let right: NSLayoutConstraint?
    let height: NSLayoutConstraint?
    let width: NSLayoutConstraint?
    let centerX: NSLayoutConstraint?
    let centerY: NSLayoutConstraint?

    // MARK: - Initializers

    init(view: UIView) {
        self.view = view
        top = nil
        left = nil
        bottom = nil
        right = nil
        height = nil
        width = nil
        centerX = nil
        centerY = nil
    }

    private init(
        view: UIView,
        top: NSLayoutConstraint?,
        left: NSLayoutConstraint?,
        bottom: NSLayoutConstraint?,
        right: NSLayoutConstraint?,
        height: NSLayoutConstraint?,
        width: NSLayoutConstraint?,
        centerX: NSLayoutConstraint?,
        centerY: NSLayoutConstraint?
    ) {
        self.view = view
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
        self.height = height
        self.width = width
        self.centerX = centerX
        self.centerY = centerY
    }

    // MARK: - Update

    private func update(edge: NSLayoutConstraint.Attribute, constraint: NSLayoutConstraint?) -> Anchor {
        var top = self.top
        var left = self.left
        var bottom = self.bottom
        var right = self.right
        var height = self.height
        var width = self.width
        var centerX = self.centerX
        var centerY = self.centerY

        switch edge {
        case .top: top = constraint
        case .left: left = constraint
        case .bottom: bottom = constraint
        case .right: right = constraint
        case .height: height = constraint
        case .width: width = constraint
        case .centerX: centerX = constraint
        case .centerY: centerY = constraint
        default: return self
        }

        return Anchor(
            view: view,
            top: top,
            left: left,
            bottom: bottom,
            right: right,
            height: height,
            width: width,
            centerX: centerX,
            centerY: centerY
        )
    }

    private func insert(anchor: Anchor) -> Anchor {
        Anchor(
            view: view,
            top: anchor.top ?? top,
            left: anchor.left ?? left,
            bottom: anchor.bottom ?? bottom,
            right: anchor.right ?? right,
            height: anchor.height ?? height,
            width: anchor.width ?? width,
            centerX: anchor.centerX ?? centerX,
            centerY: anchor.centerY ?? centerY
        )
    }

    // MARK: - Anchor to superview edges

    func topToSuperview(constant: CGFloat = 0) -> Anchor {
        guard let superview = view.superview else { return self }
        return top(to: superview.top, constant: constant)
    }

    func leftToSuperview(constant: CGFloat = 0) -> Anchor {
        guard let superview = view.superview else { return self }
        return left(to: superview.left, constant: constant)
    }

    func bottomToSuperview(constant: CGFloat = 0) -> Anchor {
        guard let superview = view.superview else { return self }
        return bottom(to: superview.bottom, constant: constant)
    }

    func rightToSuperview(constant: CGFloat = 0) -> Anchor {
        guard let superview = view.superview else { return self }
        return right(to: superview.right, constant: constant)
    }

    func edgesToSuperview(
        omitEdge edge: NSLayoutConstraint.Attribute = .notAnAttribute,
        insets: UIEdgeInsets = UIEdgeInsets.zero
    ) -> Anchor {
        let superviewAnchors = topToSuperview(constant: insets.top)
            .leftToSuperview(constant: insets.left)
            .bottomToSuperview(constant: -insets.bottom)
            .rightToSuperview(constant: -insets.right)
            .update(edge: edge, constraint: nil)
        return insert(anchor: superviewAnchors)
    }

    // MARK: - Anchor to superview axises

    func centerXToSuperview() -> Anchor {
        guard let superview = view.superview else { return self }
        return centerX(to: superview.centerX)
    }

    func centerYToSuperview() -> Anchor {
        guard let superview = view.superview else { return self }
        return centerY(to: superview.centerY)
    }

    func centerToSuperview() -> Anchor {
        guard let superview = view.superview else { return self }
        return centerX(to: superview.centerX)
            .centerY(to: superview.centerY)
    }

    // MARK: - Anchor to

    func top(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .top, constraint: view.top.constraint(equalTo: anchor, constant: constant))
    }

    func left(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .left, constraint: view.left.constraint(equalTo: anchor, constant: constant))
    }

    func bottom(to anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .bottom, constraint: view.bottom.constraint(equalTo: anchor, constant: constant))
    }

    func right(to anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .right, constraint: view.right.constraint(equalTo: anchor, constant: constant))
    }

    // MARK: - Anchor greaterOrEqual

    func top(greaterOrEqual anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .top, constraint: view.top.constraint(greaterThanOrEqualTo: anchor, constant: constant))
    }

    func left(greaterOrEqual anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .left, constraint: view.left.constraint(greaterThanOrEqualTo: anchor, constant: constant))
    }

    func bottom(greaterOrEqual anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .bottom, constraint: view.bottom.constraint(greaterThanOrEqualTo: anchor, constant: constant))
    }

    func right(greaterOrEqual anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .right, constraint: view.right.constraint(greaterThanOrEqualTo: anchor, constant: constant))
    }

    // MARK: - Anchor lessOrEqual

    func top(lesserOrEqual anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .top, constraint: view.top.constraint(lessThanOrEqualTo: anchor, constant: constant))
    }

    func left(lesserOrEqual anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .left, constraint: view.left.constraint(lessThanOrEqualTo: anchor, constant: constant))
    }

    func bottom(lesserOrEqual anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .bottom, constraint: view.bottom.constraint(lessThanOrEqualTo: anchor, constant: constant))
    }

    func right(lesserOrEqual anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> Anchor {
        update(edge: .right, constraint: view.right.constraint(lessThanOrEqualTo: anchor, constant: constant))
    }

    // MARK: - Dimension anchors

    func height(constant: CGFloat) -> Anchor {
        update(edge: .height, constraint: view.height.constraint(equalToConstant: constant))
    }

    func height(to dimension: NSLayoutDimension, multiplier: CGFloat = 1) -> Anchor {
        update(edge: .height, constraint: view.height.constraint(equalTo: dimension, multiplier: multiplier))
    }

    func width(constant: CGFloat) -> Anchor {
        update(edge: .width, constraint: view.width.constraint(equalToConstant: constant))
    }

    func width(to dimension: NSLayoutDimension, multiplier: CGFloat = 1) -> Anchor {
        update(edge: .width, constraint: view.width.constraint(equalTo: dimension, multiplier: multiplier))
    }

    // MARK: - Axis anchors

    func centerX(to axis: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Anchor {
        update(edge: .centerX, constraint: view.centerX.constraint(equalTo: axis, constant: constant))
    }

    func centerY(to axis: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Anchor {
        update(edge: .centerY, constraint: view.centerY.constraint(equalTo: axis, constant: constant))
    }

    // MARK: - Activation

    @discardableResult
    func activate() -> Anchor {
        view.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [top, left, bottom, right, height, width, centerX, centerY].compactMap { $0 }
        NSLayoutConstraint.activate(constraints)
        return self
    }
}
