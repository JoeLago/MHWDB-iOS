//
//  ActivityIndicator.swift
//  MHWDB
//
//  Created by Joe on 12/12/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

// Delete for iOS 14
struct ActivityIndicator: UIViewRepresentable {
    typealias UIView = UIActivityIndicatorView
    var isAnimating: Bool
    var configuration = { (indicator: UIView) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView { UIView() }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}
