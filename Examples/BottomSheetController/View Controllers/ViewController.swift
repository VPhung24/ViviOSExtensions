//
//  ViewController.swift
//  BottomSheetController
//
//  Created by Thomas Asheim Smedmann on 04/05/2022.
//

import UIKit
import VivUIExtensions
import VivBottomSheet

final class ViewController: UIViewController {
    
    lazy private var stackView = UIStackView(axis: traitCollection.horizontalSizeClass == .compact ? .vertical : .horizontal).configured {
        $0.spacing = 16
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        
        let sparseContentStackView = UIStackView(arrangedSubViews: BottomSheetExampleType.sparse.sizes.map { sizing in
            return UIButton(type: .system, primaryAction: UIAction { [weak self] _ in
                self?.actionForBottomSheetExample(type: .sparse, size: sizing)
            }).configured {
                $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
                $0.setTitle("Sparse context - \(sizing.string)", for: .normal)
            }
        }, axis: .vertical).configured {
            $0.spacing = 8
        }

        let denseContentStackView = UIStackView(arrangedSubViews: BottomSheetExampleType.dense.sizes.map { sizing in
            return UIButton(type: .system, primaryAction: UIAction { [weak self] _ in
                self?.actionForBottomSheetExample(type: .dense, size: sizing)
            }).configured {
                $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
                $0.setTitle("Dense content - \(sizing.string)", for: .normal)
            }
        }, axis: .vertical).configured {
            $0.spacing = 8
        }
        
        let expandingContentMediumButton = UIButton(type: .system, primaryAction: UIAction { [weak self] _ in
            self?.actionForBottomSheetExample(type: .expanding, size: .fit)
        }).configured {
            $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
            $0.setTitle("Expanding content - fit", for: .normal)
        }

        stackView.addArrangedSubview(sparseContentStackView)
        stackView.addArrangedSubview(denseContentStackView)
        stackView.addArrangedSubview(expandingContentMediumButton)
        
        view.addSubviewWithConstraints(stackView, [
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let axis: NSLayoutConstraint.Axis = traitCollection.horizontalSizeClass == .compact ? .vertical : .horizontal
        stackView.axis = axis
    }
    
    private func actionForBottomSheetExample(type: BottomSheetExampleType, size: BottomSheetController.PreferredSheetSizing) {
        let viewController: BottomSheetController = {
            switch type {
            case .sparse:
                return SparseContentSheetViewController()
            case .dense:
                return DenseContentSheetViewController()
            case .expanding:
                return ExpandingContentSheetViewController()
            }
        }()
        
        viewController.preferredSheetSizing = size
        viewController.panToDismissEnabled = false
        self.present(viewController, animated: true)
    }
}
