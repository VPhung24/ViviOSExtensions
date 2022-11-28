//
//  BottomSheetType.swift
//  VivBottomSheet
//
//  Created by Vivian Phung on 11/28/22.
//

import Foundation

public enum BottomSheetExampleType: String {
    case sparse, dense, expanding
    
   public var sizes: [BottomSheetController.PreferredSheetSizing] {
        switch self {
        case .expanding:
            return [.fill]
        default:
            return [.fit, .small, .medium, .large, .fill]
        }
    }
}
