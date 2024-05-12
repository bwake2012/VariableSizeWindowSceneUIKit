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

    struct SizeButton: Identifiable {
        var id: String { title }

        let title: String
        let width: CGFloat
        let height: CGFloat
        let imageName: String

        var size: CGSize {
            CGSize(width: width, height: height)
        }
    }

    static var buttonList: [SizeButton] = {
        [
            SizeButton(title: "Portrait", width: 480, height: 640, imageName: "rectangle.portrait.fill"),
            SizeButton(title: "Landscape", width: 640, height: 480, imageName: "rectangle.fill"),
            SizeButton(title: "Large Square", width: 640, height: 640, imageName: "square.fill"),
            SizeButton(title: "Small Square", width: 480, height: 480, imageName: "square.fill"),
            SizeButton(title: "Smaller Square", width: 360, height: 360, imageName: "square.fill"),
            SizeButton(title: "Very Small Square", width: 240, height: 240, imageName: "square.fill"),
            SizeButton(title: "Tiny Square", width: 180, height: 180, imageName: "square.fill")
        ]
    }()

    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4.0
        stackView.distribution = .fillEqually
        for item in Self.buttonList {
            stackView.addArrangedSubview(buildResizeButton(item))
        }
        return stackView
    }()

    private func buildResizeButton(_ sizeButton: SizeButton) -> UIButton {

        let title = String(format: "%@ %3.0f,%3.0f", sizeButton.title, sizeButton.width, sizeButton.height)
        let action = UIAction(title: title) { (action) in
            self.view.window?.windowScene?.resize(to: sizeButton.size)
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

    lazy var sizeButtonOrnament = buildSizeButtonOrnament()

    private func buildSizeDisplayOrnament(size: CGSize) -> UIOrnament {
        let ornament = UIHostingOrnament(sceneAnchor: .bottom, contentAlignment: .top) {
            HStack(spacing: 4) {
                Text(String(format: "%3.0f", size.width))
                Text(String(format: "%3.0f", size.height))
            }
            .padding()
            .glassBackgroundEffect(displayMode: .implicit)
        }
        return ornament
    }

    private func buildSizeButtonOrnament() -> UIOrnament {
        let ornament = UIHostingOrnament(sceneAnchor: .leading, contentAlignment: .trailing) {
            VStack(spacing: 4) {
                ForEach(Self.buttonList) { button in
                    Button(button.title, systemImage: button.imageName) {
                        self.view.window?.windowScene?.resize(to: button.size)
                    }
                }
            }
            .padding()
            .glassBackgroundEffect(displayMode: .implicit)
        }

        return ornament
    }

    override func loadView() {
        super.loadView()

        view.addSubview(buttonStack)

        NSLayoutConstraint.activate(edgeConstraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let size = view.bounds.size
        ornaments = [sizeButtonOrnament, buildSizeDisplayOrnament(size: size)]
    }

    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        ornaments = [sizeButtonOrnament, buildSizeDisplayOrnament(size: size)]
    }
}

