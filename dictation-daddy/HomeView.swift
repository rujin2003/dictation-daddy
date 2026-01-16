//
//  HomeVIew.swift
//  dictation-daddy
//
//  Created by Rujin Devkota on 1/16/26.
//

import SwiftUI


// MARK: - Home Page
struct HomePage: View {
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            
            VStack {
                Text("VoiceBoard")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppColors.primary)
                
                Spacer()
                
                Text("Home Page")
                    .font(.system(size: 18))
                    .foregroundColor(AppColors.textPrimary)
                
                Spacer()
            }
            .padding()
        }
    }
}

