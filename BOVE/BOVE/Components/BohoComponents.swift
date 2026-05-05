//
//  BohoComponents.swift
//  BOVE
//
//  Reusable production-level components for the Boat Safety app.
//

import SwiftUI

// MARK: - Primary Button
struct PrimaryButton: View {
    let title: String
    let icon: String?
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                }
                Text(title)
                    .font(.system(size: 17, weight: .bold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                Capsule()
                    .fill(isEnabled ? BohoColors.terracottaGradient : LinearGradient(colors: [.gray.opacity(0.3)], startPoint: .leading, endPoint: .trailing))
            )
            .shadow(color: isEnabled ? Color(red: 0.80, green: 0.42, blue: 0.36).opacity(0.3) : .clear, radius: 10, y: 5)
        }
        .disabled(!isEnabled)
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Counter View
struct CounterView: View {
    @Binding var count: Int
    let max: Int
    
    var body: some View {
        HStack(spacing: 30) {
            CounterButton(icon: "minus", color: BohoColors.dangerRed) {
                if count > 0 { count -= 1 }
            }
            
            CounterButton(icon: "plus", color: BohoColors.safeGreen) {
                count += 1
            }
        }
    }
}

struct CounterButton: View {
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .background(Circle().fill(color))
                .shadow(color: color.opacity(0.3), radius: 8, y: 4)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Helper Button Style
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Floating SOS Button
struct FloatingSOSButton: View {
    @State private var pulse = 1.0
    
    var body: some View {
        Button(action: { /* Emergency Action */ }) {
            Text("SOS")
                .font(.system(size: 14, weight: .heavy))
                .foregroundColor(.white)
                .frame(width: 54, height: 54)
                .background(Circle().fill(BohoColors.dangerRed))
                .overlay(
                    Circle()
                        .stroke(BohoColors.dangerRed, lineWidth: 2)
                        .scaleEffect(pulse)
                        .opacity(2.0 - pulse)
                )
                .shadow(color: BohoColors.dangerRed.opacity(0.4), radius: 10)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: false)) {
                pulse = 2.0
            }
        }
    }
}
