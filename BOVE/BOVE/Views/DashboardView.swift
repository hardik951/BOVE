//
//  DashboardView.swift
//  BOVE
//
//  Redesigned Dashboard with improved hierarchy, contrast, and spacing.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        ZStack {
            // Background
            BohoColors.backgroundGradient
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("BOVE")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(BohoColors.terracotta)
                                .tracking(2)
                            
                            Text("Dashboard")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(BohoColors.textPrimary)
                        }
                        Spacer()
                        
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(BohoColors.textSecondary)
                    }
                    .padding(.top, 10)
                    
                    // Passenger Counter Card
                    VStack(spacing: 20) {
                        Text("PASSENGERS")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(BohoColors.textSecondary)
                            .tracking(1.5)
                        
                        ZStack {
                            // Progress Ring
                            Circle()
                                .stroke(BohoColors.textTertiary.opacity(0.1), lineWidth: 20)
                            
                            Circle()
                                .trim(from: 0, to: appState.capacityProgress)
                                .stroke(
                                    appState.capacityStatus.color,
                                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                                )
                                .rotationEffect(.degrees(-90))
                                .animation(.spring(), value: appState.capacityProgress)
                            
                            VStack(spacing: -4) {
                                Text("\(appState.currentPassengers)")
                                    .font(.system(size: 64, weight: .black, design: .rounded))
                                    .foregroundColor(BohoColors.textPrimary)
                                
                                Text("of \(appState.maxCapacity)")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(BohoColors.textTertiary)
                            }
                        }
                        .frame(width: 200, height: 200)
                        
                        // Controls
                        CounterView(count: $appState.currentPassengers, max: appState.maxCapacity)
                            .padding(.top, 10)
                    }
                    .padding(24)
                    .glassCard()
                    
                    // Safety Checklist Card
                    VStack(alignment: .leading, spacing: 16) {
                        Text("SAFETY CHECKLIST")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(BohoColors.textSecondary)
                            .tracking(1.5)
                        
                        VStack(spacing: 12) {
                            ForEach(appState.safetyChecks.indices, id: \.self) { index in
                                SafetyToggle(item: $appState.safetyChecks[index])
                            }
                        }
                    }
                    .padding(24)
                    .glassCard()
                    
                    // Start Trip CTA
                    PrimaryButton(
                        title: "Start Trip",
                        icon: "sailboat.fill",
                        isEnabled: appState.canStartTrip,
                        action: { appState.startTrip() }
                    )
                    .padding(.top, 8)
                    
                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 20)
            }
            
            // SOS Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    FloatingSOSButton()
                        .padding(.trailing, 24)
                        .padding(.bottom, 100)
                }
            }
        }
    }
}

// MARK: - Safety Toggle Component
struct SafetyToggle: View {
    @Binding var item: SafetyCheckItem
    
    var body: some View {
        Button(action: { item.isChecked.toggle() }) {
            HStack {
                Image(systemName: item.icon)
                    .font(.system(size: 18))
                    .foregroundColor(item.isChecked ? .white : BohoColors.textSecondary)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle().fill(item.isChecked ? BohoColors.oliveGreen : Color.clear)
                    )
                    .overlay(Circle().stroke(BohoColors.textTertiary.opacity(0.3), lineWidth: 1))
                
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(BohoColors.textPrimary)
                
                Spacer()
                
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(item.isChecked ? BohoColors.oliveGreen : BohoColors.textTertiary.opacity(0.5))
            }
            .padding(.horizontal, 16)
            .frame(height: 64)
            .background(
                Capsule()
                    .fill(item.isChecked ? BohoColors.oliveGreen.opacity(0.05) : Color.white.opacity(0.05))
            )
            .overlay(
                Capsule()
                    .stroke(item.isChecked ? BohoColors.oliveGreen.opacity(0.3) : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}
