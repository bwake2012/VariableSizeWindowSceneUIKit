// SizeButtonOrnamentContent.swift
//
// Created by Bob Wakefield on 11/22/24.
// for VariableSizeWindowSceneUIKit
//
// Using Swift 6.0
// Running on macOS 15.0
//
// 
//

import SwiftUI

struct SizeButtonOrnamentContent: View {

    private let buttonList: [SizeButtonTemplate]
    private let view: UIView

    @State var selectedSize: CGSize

    var body: some View {
        VStack(spacing: 8) {
            ForEach(buttonList) { button in
                Button(
                    button.completeTitle,
                    systemImage: button.imageName(currentSize: selectedSize)
                ) {
                    self.view.window?.windowScene?.resize(to: button.size)
                    print("resize to: \(button.size.width),\(button.size.height)")
                }
            }
        }
        .padding()
        .glassBackgroundEffect(displayMode: .implicit)
    }

    init(buttonList: [SizeButtonTemplate], view: UIView, selectedSize: CGSize) {
        self.buttonList = buttonList
        self.view = view
        self.selectedSize = selectedSize
    }
}
