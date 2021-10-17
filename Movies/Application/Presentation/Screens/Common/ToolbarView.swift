// ToolbarView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

/// UI component with blurred backbground. Should be used on the bottom of the screen
class ToolbarView: UIView {
    // MARK: - Static properties

    static var height: CGFloat {
        Appearance.padding.vertical + Appearance.contentViewHeight
    }

    // MARK: - Properties

    let visualEffectView: UIVisualEffectView = {
        UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    }()

    let separatorView: UIView = {
        UIView()
    }()

    var contentView: UIView? {
        didSet { didSetContentView(oldValue: oldValue) }
    }

    // MARK: - Initializer

    required init() {
        super.init(frame: .zero)

        setComponentsConstraints()
        configureComponents()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Acion methods

    private func didSetContentView(oldValue: UIView?) {
        oldValue?.removeFromSuperview()
        guard let contentView = contentView else { return }
        setContentViewComponent(contentView)
    }
}

// MARK: - UI Configure methods

private extension ToolbarView {
    func configureComponents() {
        configureSeparatorViewComponent()
    }

    func configureSeparatorViewComponent() {
        separatorView.backgroundColor = .opaqueSeparator
        separatorView.alpha = 0.3
    }
}

// MARK: - UI Setup methods

private extension ToolbarView {
    func setComponentsConstraints() {
        setVisualEffectViewConstraints()
        setSeparatorViewComponent()
    }

    func setVisualEffectViewConstraints() {
        addSubview(visualEffectView)
        visualEffectView.anchor
            .edgesToSuperview()
            .activate()
    }

    func setSeparatorViewComponent() {
        visualEffectView.contentView.addSubview(separatorView)
        separatorView.anchor
            .leftToSuperview()
            .rightToSuperview()
            .topToSuperview()
            .height(constant: 0.5)
            .activate()
    }

    func setContentViewComponent(_ view: UIView) {
        visualEffectView.contentView.addSubview(view)
        view.anchor
            .leftToSuperview(constant: Appearance.padding.left)
            .rightToSuperview(constant: Appearance.padding.right)
            .top(to: separatorView.bottom, constant: Appearance.padding.top)
            .bottomToSuperview(constant: -Appearance.padding.bottom)
            .height(constant: Appearance.contentViewHeight)
            .activate()
    }
}

// MARK: - Appearance

extension ToolbarView {
    enum Appearance {
        static let padding: UIEdgeInsets = .init(
            top: 0,
            left: 0,
            bottom: UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? .zero,
            right: 0
        )
        static let contentViewHeight: CGFloat = 58.0
    }
}
