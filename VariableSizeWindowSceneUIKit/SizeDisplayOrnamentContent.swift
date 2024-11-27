// SizeDisplayOrnamentContent.swift
//
// Created by Bob Wakefield on 11/25/24.
// for VariableSizeWindowSceneUIKit
//
// Using Swift 6.0
// Running on macOS 15.1
//
// 
//

import SwiftUI

struct SizeDisplayOrnamentContent: View {
    @State var currentSize: CGSize
    var body: some View {
        HStack {
            Text("Actual Size:")
            Text(String(format: "%3.0f,%3.0f", currentSize.width, currentSize.height))
        }
        .padding()
        .glassBackgroundEffect(displayMode: .implicit)
    }

    init(currentSize: CGSize) {
        self.currentSize = currentSize
    }
}

#Preview {
    SizeDisplayOrnamentContent(currentSize: CGSize(width: 640, height: 480))
}
