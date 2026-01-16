//
//  ContentView.swift
//  dictation-daddy
//
//  Created by Rujin Devkota on 1/16/26.
//

import SwiftUI

// MARK: - Root
struct ContentView: View {
    @State private var showHome = false
    
    var body: some View {
        if showHome {
            HomePage()
        } else {
          OnboardingView(isOnboardingComplete: $showHome)
        }
    }
}
