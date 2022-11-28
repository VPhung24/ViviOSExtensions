//
//  SparseContentSheetViewController.swift
//  VivUIExtensions
//
//  Created by Vivian Phung on 11/28/22.
//

import UIKit
import VivUIExtensions
import VivBottomSheet

final class SparseContentSheetViewController: BottomSheetController {

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground

        let label = UILabel().configured {
            $0.font = .systemFont(ofSize: 17, weight: .regular)
            $0.text = "Hello! 👋"
        }

        let button = UIButton(type: .system, primaryAction: UIAction { _ in
            self.dismiss(animated: true)
        }).configured {
            $0.setImage(UIImage(systemName: "minus")?.withTintColor(.label, renderingMode: .alwaysOriginal), for: .normal)
        }
        
        view.addSubviewWithConstraints(button, [
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        view.addSubviewWithConstraints(label, [
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

            label.topAnchor.constraint(greaterThanOrEqualTo: button.bottomAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor),
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
