//
//  UnityViewModel.swift
//  UnityInSwiftUI
//
//  Created by Nelson on 2021/8/3.
//

import Foundation

final class UnityViewModel: ObservableObject {
    @Published var isUnityLoaded = false

    init() {
        UnityManager.shared.onReceiveMessage = handleUnityMessage(message:)
    }

    func loadUnity() {
        UnityManager.shared.load()
    }

    private func handleUnityMessage(message: String) {
        switch message {
        case "ready":
            isUnityLoaded = true
        default:
            break
        }
    }
}
