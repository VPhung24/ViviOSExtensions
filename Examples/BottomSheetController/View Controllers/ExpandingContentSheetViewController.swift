//
//  ExpandingContentSheetViewController.swift
//  VivBottomSheet
//
//  Created by Vivian Phung on 11/28/22.
//

import UIKit
import VivBottomSheet

final class ExpandingContentSheetViewController: BottomSheetController {

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground

        let labelOne = UILabel().configured {
            $0.font = .systemFont(ofSize: 24, weight: .regular)
            $0.text = "Hello there! 👋🧔🏼‍♂️"
        }

        let labelTwo = UILabel().configured {
            $0.font = .systemFont(ofSize: 24, weight: .regular)
            $0.text = "General Kenobi... 🫵🤖"
            $0.isHidden = true
            $0.alpha = 0
        }

        let expandButton = UIButton(type: .system).configured {
            $0.setImage(.init(systemName: "chevron.up"), for: .normal)
        }
        expandButton.addAction(.init(handler: { _ in
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
                labelTwo.isHidden = !labelTwo.isHidden
                labelTwo.alpha = labelTwo.isHidden ? 0 : 1
                expandButton.setImage(
                    labelTwo.isHidden ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"),
                    for: .normal
                )
            })
        }), for: .primaryActionTriggered)

        let horizontalStackView = UIStackView(arrangedSubViews: [labelOne, expandButton], axis: .horizontal).configured {
            $0.spacing = 16
        }

        let verticalStackView = UIStackView(arrangedSubViews: [horizontalStackView, labelTwo], axis: .vertical).configured {
            $0.spacing = 16
        }

        let closeButton = UIButton(type: .system, primaryAction: UIAction {_ in
            self.dismiss(animated: true)
        }).configured {
            $0.setImage(UIImage(systemName: "minus")?.withTintColor(.label, renderingMode: .alwaysOriginal), for: .normal)
        }

        view.addSubviewWithConstraints(closeButton, [
            labelTwo.heightAnchor.constraint(equalToConstant: 100),

            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
            closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubviewWithConstraints(verticalStackView, [
            verticalStackView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 32),
            verticalStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            verticalStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
}
