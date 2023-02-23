//
//  UILabel+Extensions.swift
//  
//
//  Created by Vivian Phung on 2/23/23.
//

import UIKit

extension UILabel {
    static func defaultLabel(with alignment: NSTextAlignment = .natural) -> UILabel {
        let label = UILabel(frame: .zero)
        label.adjustsFontForContentSizeCategory = true
        label.accessibilityTraits = .staticText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = alignment
        return label
    }
}
