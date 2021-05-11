// SegmentedControl.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol SegmentedControlDelegate: AnyObject {
    func segmentedControl(_ segmentedControl: SegmentedControl, didSelectItemAt index: Int)
}

protocol SegmentedControlDataSource: AnyObject {
    func numberOfItems(segmentedControl: SegmentedControl) -> Int
    func segmentedControl(_ segmentedControl: SegmentedControl, by index: Int) -> String
}

final class SegmentedControl: UISegmentedControl {
    // MARK: - Properties

    weak var delegate: SegmentedControlDelegate?
    weak var dataSource: SegmentedControlDataSource?

    // MARK: - Life cycle methods

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        configureSegmentedControl()
    }

    // MARK: - Overriden gesture recognizer methods

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard type(of: gestureRecognizer).description() != "UIScrollViewPanGestureRecognizer" else { return true }
        return super.gestureRecognizerShouldBegin(gestureRecognizer)
    }

    // MARK: - Methods

    public func reloadData() {
        configureSegmentedControl()
    }

    // MARK: - Setup methods

    private func configureSegmentedControl() {
        configureSegments()
        configureDelegate()
    }

    private func configureSegments() {
        guard let items = dataSource?.numberOfItems(segmentedControl: self) else { return }
        removeAllSegments()

        (0 ..< items).forEach { index in
            let item = dataSource?.segmentedControl(self, by: index)
            insertSegment(withTitle: item, at: index, animated: false)
        }
    }

    private func configureDelegate() {
        addTarget(self, action: #selector(didSelectItem(_:)), for: .valueChanged)
    }

    // MARK: - Actions

    @objc private func didSelectItem(_ sender: SegmentedControl) {
        delegate?.segmentedControl(sender, didSelectItemAt: sender.selectedSegmentIndex)
    }
}
