//
//  SplashScreen.swift
//  emoji-map
//
//  Created by Enrique on 3/7/25.
//

import SwiftUI

struct SplashScreen: View {
    // Animation states
    @State private var showLogo = false
    @State private var showTitle = false
    @State private var showTagline = false
    @State private var finishedAnimation = false
    
    // Completion handler
    var onFinished: () -> Void
    
    // MARK: - Emoji Decoration
    
    private struct EmojiDecoration {
        let emoji: String
        let x: CGFloat
        let y: CGFloat
        let rotation: Double
        let scale: CGFloat
    }
    
    // Predefined emoji decorations for consistent, performant rendering
    private let emojiDecorations: [EmojiDecoration] = [
        EmojiDecoration(emoji: "🍕", x: 50, y: 100, rotation: 15, scale: 1.2),
        EmojiDecoration(emoji: "🍔", x: 300, y: 150, rotation: -20, scale: 1.0),
        EmojiDecoration(emoji: "🌮", x: 150, y: 300, rotation: 45, scale: 1.3),
        EmojiDecoration(emoji: "🍣", x: 250, y: 400, rotation: -30, scale: 0.8),
        EmojiDecoration(emoji: "🍜", x: 100, y: 500, rotation: 10, scale: 1.1),
        EmojiDecoration(emoji: "🍦", x: 350, y: 200, rotation: -15, scale: 1.4),
        EmojiDecoration(emoji: "🍷", x: 200, y: 250, rotation: 25, scale: 0.9),
        EmojiDecoration(emoji: "🍺", x: 300, y: 350, rotation: -40, scale: 1.2),
        EmojiDecoration(emoji: "☕️", x: 150, y: 450, rotation: 30, scale: 1.0),
        EmojiDecoration(emoji: "🥗", x: 250, y: 150, rotation: -25, scale: 1.1),
        EmojiDecoration(emoji: "🍲", x: 100, y: 300, rotation: 15, scale: 1.3),
        EmojiDecoration(emoji: "🥪", x: 350, y: 400, rotation: -35, scale: 0.9)
    ]
    
    var body: some View {
        ZStack {
            // Background
            backgroundLayer
            
            // Emoji decorations
            emojiLayer
            
            // Content
            contentLayer
        }
        .onAppear {
            startAnimations()
        }
        .opacity(finishedAnimation ? 0 : 1)
        .zIndex(finishedAnimation ? -1 : 100)
        .transition(.opacity)
    }
    
    // MARK: - View Components
    
    private var backgroundLayer: some View {
        ZStack {
            Color.blue.opacity(0.8)
                .ignoresSafeArea()
            
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
    }
    
    private var emojiLayer: some View {
        ForEach(emojiDecorations.indices, id: \.self) { index in
            Text(emojiDecorations[index].emoji)
                .font(.system(size: 30 * emojiDecorations[index].scale))
                .position(x: emojiDecorations[index].x, y: emojiDecorations[index].y)
                .rotationEffect(.degrees(emojiDecorations[index].rotation))
        }
    }
    
    private var contentLayer: some View {
        VStack(spacing: 20) {
            // App logo
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 2)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                .opacity(showLogo ? 1 : 0)
                .scaleEffect(showLogo ? 1 : 0.5)
            
            // App title
            Text("Emoji Map")
                .font(.system(size: 40, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .opacity(showTitle ? 1 : 0)
                .offset(y: showTitle ? 0 : 20)
            
            // App tagline
            Text("Smooth Brain? Smooth Map")
                .font(.system(size: 20, weight: .medium, design: .rounded))
                .foregroundColor(.white.opacity(0.9))
                .opacity(showTagline ? 1 : 0)
                .offset(y: showTagline ? 0 : 15)
        }
        .padding()
    }
    
    // MARK: - Animation
    
    private func startAnimations() {
        withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
            showLogo = true
        }
        
        withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(0.3)) {
            showTitle = true
        }
        
        withAnimation(.spring(response: 0.8, dampingFraction: 0.7).delay(0.5)) {
            showTagline = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeOut(duration: 0.5)) {
                finishedAnimation = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                onFinished()
            }
        }
    }
}

// MARK: - View Extension

extension View {
    func splashScreen(isPresented: Binding<Bool>, onDismiss: @escaping () -> Void) -> some View {
        ZStack {
            self
            
            if isPresented.wrappedValue {
                SplashScreen(onFinished: {
                    isPresented.wrappedValue = false
                    onDismiss()
                })
                .transition(.opacity)
            }
        }
    }
}

// MARK: - Preview

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen {
            // No logging in preview
        }
    }
} 
