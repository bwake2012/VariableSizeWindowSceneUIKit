// ViewController.swift
//
// Created by Bob Wakefield on 5/5/24.
// for VariableSizeWindowSceneUIKit
//
// Using Swift 5.0
// Running on macOS 14.4
//
// 
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [portraitButton, landscapeButton, largeSquareButton, smallSquareButton, verySmallSquareButton, tinySquareButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4.0
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var portraitButton: UIButton = {
        buildResizeButton("Portrait", width: 480, height: 640)
    }()

    private lazy var landscapeButton: UIButton = {
        buildResizeButton("Landscape", width: 640, height: 480)
    }()

    private lazy var largeSquareButton: UIButton = {
        buildResizeButton("Large Square", width: 640, height: 640)
    }()

    private lazy var smallSquareButton: UIButton = {
        buildResizeButton("Small Square", width: 480, height: 480)
    }()

    private lazy var verySmallSquareButton: UIButton = {
        buildResizeButton("Very Small Square", width: 240, height: 240)
    }()

    private lazy var tinySquareButton: UIButton = {
        buildResizeButton("Tiny Square", width: 180, height: 180)
    }()

    private func buildResizeButton(_ caption: String, width: CGFloat, height: CGFloat) -> UIButton {

        let title = String(format: "%@ %3.0f,%3.0f", caption, width, height)
        let action = UIAction(title: title) { (action) in
            self.view.window?.windowScene?.resize(to: CGSize(width: width, height: height))
        }

        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button

    }

    private lazy var screenSizeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private lazy var topConstraint = buttonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
    private lazy var leadingConstraint = buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8)
    private lazy var trailingConstraint = view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: buttonStack.trailingAnchor, constant: 8)
    private lazy var bottomConstraint = view.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: buttonStack.bottomAnchor, constant: 8)

    private lazy var edgeConstraints = [
        topConstraint, leadingConstraint, bottomConstraint, trailingConstraint
    ]

    @IBAction
    private func showOrnaments(display string: String) {
        #if os(visionOS)
        let ornament = UIHostingOrnament(sceneAnchor: .bottom, contentAlignment: .top) {
            VStack {
                Text(verbatim: string)
            }
            .padding()
            .glassBackgroundEffect(displayMode: .implicit)
        }
        ornaments = [ornament]
        #endif
    }


    override func loadView() {
        super.loadView()

        view.addSubview(buttonStack)

        NSLayoutConstraint.activate(edgeConstraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        showOrnaments(display: String(format: "%3.0f,%3.0f", size.width, size.height))
    }
}

