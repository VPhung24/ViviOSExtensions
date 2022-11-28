//
//  DenseContentSheetViewController.swift
//  VivBottomSheet
//
//  Created by Vivian Phung on 11/28/22.
//

import UIKit
import VivBottomSheet

final class DenseContentSheetViewController: BottomSheetController {

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground

        let topLabel = UILabel().configured {
            $0.font = .systemFont(ofSize: 17, weight: .regular)
            $0.numberOfLines = 0
            $0.text = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse mattis, est sed facilisis auctor, velit nunc facilisis lorem, quis consectetur elit lorem eget nisl.
            """
        }

        let textView = UITextView().configured {
            $0.font = .systemFont(ofSize: 17, weight: .regular)
            $0.backgroundColor = .secondarySystemBackground
            $0.layer.cornerRadius = 4
            $0.text = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse mattis, est sed facilisis auctor, velit nunc facilisis lorem, quis consectetur elit lorem eget nisl. Vivamus porttitor porttitor congue. Maecenas venenatis nunc eu sodales egestas. Phasellus ut ante in augue mollis aliquet. Morbi varius finibus orci, quis varius quam consectetur ut. Donec placerat quam at dictum fringilla. Aenean a lacus eget lacus elementum aliquam. Nullam ultrices nulla augue, sed mattis orci elementum eleifend. Proin viverra accumsan est vel aliquam.
            """
        }

        let bottomLabel = UILabel().configured {
            $0.font = .systemFont(ofSize: 17, weight: .regular)
            $0.numberOfLines = 0
            $0.text = """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse mattis, est sed facilisis auctor, velit nunc facilisis lorem, quis consectetur elit lorem eget nisl.
            """
        }
        
        let stackView = UIStackView(arrangedSubViews: [topLabel, textView, bottomLabel], axis: .vertical, distribution: .fill).configured {
            $0.spacing = 20
            $0.alignment = .fill
        }

        view.addSubviewWithInsets(stackView, UIEdgeInsets(top: 32, left: 16, bottom: 16, right: 16))
    }
}
