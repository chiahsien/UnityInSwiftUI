//
//  UnityView.swift
//  UnityInSwiftUI
//
//  Created by Nelson on 2021/8/3.
//

import SwiftUI

struct UnityView: UIViewRepresentable {
    typealias UIViewType = UIView

    func makeUIView(context: Context) -> UIView {
        guard let unityView = UnityManager.shared.unityView else {
            fatalError("Unity rootView is not ready.")
        }
        return unityView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Do nothing.
    }
}
