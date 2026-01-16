//
//  OnboardingView.swift
//  dictation-daddy
//
//  Created by Rujin Devkota on 1/16/26.
//

import SwiftUI


// MARK: - Animated Waveform
struct AnimatedWaveform: View {
    @State private var phase: CGFloat = 0
    let barCount: Int = 9
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<barCount, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(AppColors.primary)
                    .frame(width: 4)
                    .frame(height: barHeight(for: index))
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.1),
                        value: phase
                    )
            }
        }
        .onAppear {
            phase = 1
        }
    }
    
    private func barHeight(for index: Int) -> CGFloat {
        let baseHeight: CGFloat = 30
        let maxHeight: CGFloat = 80
        
        let center = CGFloat(barCount) / 2
        let distance = abs(CGFloat(index) - center)
        let normalizedDistance = distance / center
        
        let heightMultiplier = 1 - (normalizedDistance * 0.6)
        let animatedHeight = baseHeight + (maxHeight - baseHeight) * heightMultiplier
        
        return phase == 0 ? baseHeight : animatedHeight
    }
}


// MARK: - Page 1
struct OnboardingPage1: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            VStack(spacing: 12) {
                Text("Welcome to")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                
                Text("VoiceBoard")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(AppColors.primary)
            }
            
            Text("PRECISION VOICE-TO-TEXT")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(AppColors.textSecondary)
                .padding(.top, 8)
            
            Spacer().frame(height: 80)
            
            AnimatedWaveform()
                .frame(height: 80)
            
            Spacer().frame(height: 40)
            
            Text("SIGNAL PROCESSED • 99.9% ACCURACY")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(AppColors.textSecondary)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(AppColors.cardBackground)
                .cornerRadius(20)
            
            Spacer().frame(height: 80)
            
            VStack(spacing: 8) {
                Text("Speak, don't type.")
                    .font(.system(size: 18))
                    .foregroundColor(AppColors.textSecondary)
                
                Text("Turn your voice into perfect text instantly.")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
            }
            .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }
}


// MARK: - Page 2
struct OnboardingPage2: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image("aibot")
                .resizable()
                .scaledToFit()
                .frame(width: 220, height: 220)
                .padding(.bottom, 40)
            
            VStack(spacing: 12) {
                Text("AI-Powered")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Accuracy")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(AppColors.primary)
            }
            
            Spacer().frame(height: 24)
            
            VStack(spacing: 8) {
                Text("Experience industry-leading")
                    .font(.system(size: 16))
                    .foregroundColor(AppColors.textSecondary)
                
                Text("transcription. Capture every nuance in")
                    .font(.system(size: 16))
                    .foregroundColor(AppColors.textSecondary)
                
                HStack(spacing: 4) {
                    Text("English, Spanish, and more")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text("with human-")
                        .font(.system(size: 16))
                        .foregroundColor(AppColors.textSecondary)
                }
                
                Text("level precision.")
                    .font(.system(size: 16))
                    .foregroundColor(AppColors.textSecondary)
            }
            .multilineTextAlignment(.center)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }
}


// MARK: - Page 3
struct OnboardingPage3: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            ZStack {
                Circle()
                    .fill(AppColors.cardBackground)
                    .frame(width: 120, height: 120)
                
                Image(systemName: "shield.fill")
                    .font(.system(size: 50))
                    .foregroundColor(AppColors.primary)
            }
            .padding(.bottom, 40)
            
            VStack(alignment: .leading, spacing: 28) {
                Text("Privacy First")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Text("SECURE BY DESIGN")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(AppColors.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 12)
                
                PrivacyFeature(
                    icon: "lock.fill",
                    title: "Audio is processed ",
                    highlight: "locally",
                    subtitle: " and securely on your device."
                )
                
                PrivacyFeature(
                    icon: "bolt.fill",
                    title: "Data is used strictly for ",
                    highlight: "transcription",
                    subtitle: " only."
                )
                
                PrivacyFeature(
                    icon: "mic.slash.fill",
                    title: "No voice recordings are ever stored on our servers.",
                    highlight: nil,
                    subtitle: nil
                )
            }
            .padding(32)
            .background(AppColors.cardBackground)
            .cornerRadius(24)
            .padding(.horizontal, 24)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }
}


// MARK: - Onboarding Container
struct OnboardingView: View {
    @State private var currentPage = 0
    @Binding var isOnboardingComplete: Bool
    
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    if currentPage > 0 {
                        Button(action: { currentPage -= 1 }) {
                            HStack(spacing: 6) {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(AppColors.primary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(AppColors.cardBackground)
                            .cornerRadius(12)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                
                HStack(spacing: 8) {
                    ForEach(0..<3) { index in
                        Capsule()
                            .fill(index == currentPage ? AppColors.primary : AppColors.textSecondary.opacity(0.3))
                            .frame(width: index == currentPage ? 32 : 8, height: 8)
                            .animation(.spring(), value: currentPage)
                    }
                }
                .padding(.vertical, 20)
                
                TabView(selection: $currentPage) {
                    OnboardingPage1().tag(0)
                    OnboardingPage2().tag(1)
                    OnboardingPage3().tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                VStack(spacing: 16) {
                    Button(action: {
                        if currentPage < 2 {
                            currentPage += 1
                        } else {
                            isOnboardingComplete = true
                        }
                    }) {
                        Text(currentPage == 2 ? "GET STARTED" : "NEXT")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(AppColors.primary)
                            .cornerRadius(16)
                    }
                    
                    if currentPage == 0 {
                        Button(action: { isOnboardingComplete = true }) {
                            Text("Skip for now")
                                .font(.system(size: 14))
                                .foregroundColor(AppColors.textSecondary)
                        }
                        .padding(.bottom, 8)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
            }
        }
    }
}


// MARK: - Privacy Feature
struct PrivacyFeature: View {
    let icon: String
    let title: String
    let highlight: String?
    let subtitle: String?
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(AppColors.primary)
                .frame(width: 24)
            
            if let highlight = highlight, let subtitle = subtitle {
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(AppColors.textPrimary) +
                Text(highlight)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(AppColors.primary) +
                Text(subtitle)
                    .font(.system(size: 16))
                    .foregroundColor(AppColors.textPrimary)
            } else {
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(AppColors.textPrimary)
            }
        }
    }
}

