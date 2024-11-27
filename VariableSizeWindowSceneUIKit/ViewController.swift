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

    static var buttonList: [SizeButtonTemplate] = {
        [
            SizeButtonTemplate(title: "Portrait", width: 480, height: 640, imageName: "rectangle.portrait"),
            SizeButtonTemplate(title: "Landscape", width: 640, height: 480, imageName: "rectangle"),
            SizeButtonTemplate(title: "Large Square", width: 640, height: 640, imageName: "l.square"),
            SizeButtonTemplate(title: "Small Square", width: 480, height: 480, imageName: "s.square"),
            SizeButtonTemplate(title: "Smaller Square", width: 360, height: 360, imageName: "square"),
            SizeButtonTemplate(title: "Very Small Square", width: 240, height: 240, imageName: "v.square"),
            SizeButtonTemplate(title: "Tiny Square", width: 180, height: 180, imageName: "t.square")
        ]
    }()

    var sizeOrnamentAnchor: UnitPoint = .leading
    var sizeOrnamentAlignment: Alignment = .trailing

    var sizeDisplayOrnamentAnchor: UnitPoint = .bottom
    var sizeDisplayOrnamentAlignment: Alignment = .top

    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4.0
        stackView.distribution = .fillEqually
        for item in Self.buttonList {
            stackView.addArrangedSubview(buildResizeButton(item, currentSize: view.bounds.size))
        }
        return stackView
    }()

    private func buildResizeButton(_ sizeButton: SizeButtonTemplate, currentSize: CGSize) -> UIButton {

        let action = UIAction(title: sizeButton.completeTitle, image: UIImage(systemName: sizeButton.imageName(currentSize: currentSize))) { (action) in
            self.view.window?.windowScene?.resize(to: sizeButton.size)
        }

        let button = UIButton(primaryAction: action)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return button
    }

    private lazy var topConstraint = buttonStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32)
    private lazy var leadingConstraint = buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32)
    private lazy var trailingConstraint = view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: buttonStack.trailingAnchor, constant: 32)
    private lazy var bottomConstraint = view.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: buttonStack.bottomAnchor, constant: 32)

    private lazy var edgeConstraints = [
        topConstraint, leadingConstraint, bottomConstraint, trailingConstraint
    ]

    private func buildSizeDisplayOrnament(currentSize: CGSize, anchor: UnitPoint, alignment: Alignment) -> UIOrnament {
        UIHostingOrnament(sceneAnchor: .bottom, contentAlignment: .top) {
            SizeDisplayOrnamentContent(currentSize: currentSize)
        }
    }

    private func buildSizeButtonOrnament(view: UIView, currentSize: CGSize, anchor: UnitPoint, alignment: Alignment) -> UIOrnament {
        UIHostingOrnament(sceneAnchor: anchor, contentAlignment: alignment) {
            SizeButtonOrnamentContent(
                buttonList: Self.buttonList,
                view: view,
                selectedSize: currentSize)
        }
    }

    override func loadView() {
        super.loadView()

        let size = view.bounds.size
        Self.buttonList += [
            SizeButtonTemplate(title: "Original", width: size.width, height: size.height, imageName: "o.circle")
        ]

        view.addSubview(buttonStack)

        NSLayoutConstraint.activate(edgeConstraints)

        #if DEBUG
        Self.buttonList.forEach { print("\($0.title): \($0.imageName(currentSize: $0.size))")}
        #endif
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        ornaments = buildOrnaments(for: view.bounds.size)
    }

    override func viewWillTransition(to newSize: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        ornaments = buildOrnaments(for: newSize)
    }

    private func buildOrnaments(for size: CGSize) -> [UIOrnament] {
        return
            [
                buildSizeButtonOrnament(view: view, currentSize: size, anchor: sizeOrnamentAnchor, alignment: sizeOrnamentAlignment),
                buildSizeDisplayOrnament(currentSize: size, anchor: sizeDisplayOrnamentAnchor, alignment: sizeDisplayOrnamentAlignment)
            ]
    }
}

#if os(visionOS)
extension ViewController {
    override var preferredContainerBackgroundStyle: UIContainerBackgroundStyle {
        .glass
    }
}
#endif
