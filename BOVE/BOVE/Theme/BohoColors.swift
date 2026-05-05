//
//  BohoColors.swift
//  BOVE
//
//  Production-ready Boho-inspired color palette with Dark Mode support.
//

import SwiftUI

struct BohoColors {
    // MARK: - Core Palette
    static let sandBeige = Color("SandBeige", bundle: nil)
    static let terracotta = Color("Terracotta", bundle: nil)
    static let oliveGreen = Color("OliveGreen", bundle: nil)
    static let warmBrown = Color("WarmBrown", bundle: nil)
    
    // MARK: - Semantic Colors (Adapting to Dark/Light)
    static let backgroundBeige = Color(light: Color(red: 0.96, green: 0.91, blue: 0.83), 
                                      dark: Color(red: 0.12, green: 0.10, blue: 0.08))
    
    static let textPrimary = Color(light: Color(red: 0.15, green: 0.10, blue: 0.08), 
                                   dark: Color(red: 0.95, green: 0.92, blue: 0.90))
    
    static let textSecondary = Color(light: Color(red: 0.35, green: 0.28, blue: 0.22), 
                                     dark: Color(red: 0.75, green: 0.70, blue: 0.65))
    
    static let textTertiary = Color(light: Color(red: 0.52, green: 0.45, blue: 0.38), 
                                    dark: Color(red: 0.55, green: 0.50, blue: 0.45))
    
    // MARK: - Status
    static let safeGreen = Color(red: 0.25, green: 0.60, blue: 0.35)
    static let warningOrange = Color(red: 0.85, green: 0.55, blue: 0.20)
    static let dangerRed = Color(red: 0.80, green: 0.25, blue: 0.20)
    
    // MARK: - Gradients
    static let backgroundGradient = LinearGradient(
        colors: [
            Color(light: Color(red: 0.96, green: 0.92, blue: 0.85), dark: Color(red: 0.10, green: 0.08, blue: 0.06)),
            Color(light: Color(red: 0.95, green: 0.82, blue: 0.72), dark: Color(red: 0.15, green: 0.10, blue: 0.08)),
            Color(light: Color(red: 0.80, green: 0.88, blue: 0.95), dark: Color(red: 0.08, green: 0.12, blue: 0.16))
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let terracottaGradient = LinearGradient(
        colors: [Color(red: 0.80, green: 0.42, blue: 0.36), Color(red: 0.88, green: 0.58, blue: 0.48)],
        startPoint: .leading,
        endPoint: .trailing
    )
}

// MARK: - Color Helper for Dark Mode
extension Color {
    init(light: Color, dark: Color) {
        self.init(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
}
