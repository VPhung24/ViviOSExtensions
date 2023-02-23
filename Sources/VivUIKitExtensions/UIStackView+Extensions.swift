//
//  UIStackView+Extensions.swift
//  VivUIKitExtensions
//
//  Created by Vivian Phung on 11/16/22.
//

import UIKit

public extension UIStackView {
    static func configuredStackView(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.preservesSuperviewLayoutMargins = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = distribution
        stackView.axis = axis
        stackView.spacing = 10
        return stackView
    }
}
