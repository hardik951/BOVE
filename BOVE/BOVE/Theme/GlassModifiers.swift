//
//  GlassModifiers.swift
//  BOVE
//
//  Production-level glassmorphism modifiers with adjustable blur and thin borders.
//

import SwiftUI

struct GlassModifier: ViewModifier {
    var cornerRadius: CGFloat
    var material: Material
    var borderColor: Color
    var opacity: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(material)
                        .opacity(opacity)
                    
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: 0.5)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
    }
}

extension View {
    func glassCard(cornerRadius: CGFloat = 24, 
                   material: Material = .thinMaterial, 
                   borderColor: Color = .white.opacity(0.3),
                   opacity: CGFloat = 1.0) -> some View {
        self.modifier(GlassModifier(cornerRadius: cornerRadius, 
                                   material: material, 
                                   borderColor: borderColor,
                                   opacity: opacity))
    }
}
