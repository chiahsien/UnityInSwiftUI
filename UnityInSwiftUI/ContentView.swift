//
//  ContentView.swift
//  UnityInSwiftUI
//
//  Created by Nelson on 2021/8/3.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UnityViewModel()
    var body: some View {
        ZStack {
            if viewModel.isUnityLoaded {
                UnityView()
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            viewModel.loadUnity()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
