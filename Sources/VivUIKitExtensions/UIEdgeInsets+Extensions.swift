//
//  UIEdgeInsets+Extensions.swift
//  VivUIKitExtensions
//
//  Created by Vivian Phung on 11/17/22.
//

import UIKit

public extension UIEdgeInsets {
    init(_ edges: CGFloat) {
        self.init(top: edges, left: edges, bottom: edges, right: edges)
    }
}
