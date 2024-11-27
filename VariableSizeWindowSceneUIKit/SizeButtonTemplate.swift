// SizeButton.swift
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

struct SizeButtonTemplate: Identifiable {
    var id: String { title }

    let title: String
    let width: CGFloat
    let height: CGFloat
    let imageName: String

    var size: CGSize {
        CGSize(width: width, height: height)
    }

    func imageName(currentSize: CGSize) -> String {
        let name = imageName + (currentSize == self.size ? ".fill" : "")
        return name
    }

    var completeTitle: String {
        String(format: "%@ %3.0f,%3.0f", title, width, height)
    }
}
