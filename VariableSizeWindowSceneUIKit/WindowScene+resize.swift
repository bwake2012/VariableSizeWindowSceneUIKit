// WindowScene+resize.swift
//
// Created by Bob Wakefield on 5/5/24.
// for UIKitVariableSizeWindowScene
//
// Using Swift 5.0
// Running on macOS 14.4
//
// 
//

import UIKit

extension UIWindowScene {

    func resize(to newSize: CGSize) {

        #if os(iOS)
        let geometryRequest = GeometryPreferences.iOS(
            interfaceOrientations: newSize.width < newSize.height ? .portrait : .landscape
        )
        #elseif os(visionOS)
        let geometryRequest = GeometryPreferences.Vision(
            size: newSize
        )
        #endif

        requestGeometryUpdate(geometryRequest)
    }
}
