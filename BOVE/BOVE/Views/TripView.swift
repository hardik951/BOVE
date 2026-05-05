//
//  TripView.swift
//  BOVE
//
//  Redesigned Trip View with Active Trip monitoring and History list.
//

import SwiftUI

struct TripView: View {
    @ObservedObject var appState: AppState
    
    var body: some View {
        ZStack {
            BohoColors.backgroundGradient
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("TRIPS")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(BohoColors.terracotta)
                                .tracking(2)
                            
                            Text(appState.isTripActive ? "Active Monitoring" : "Trip History")
                                .font(.system(size: 34, weight: .bold))
                                .foregroundColor(BohoColors.textPrimary)
                        }
                        Spacer()
                    }
                    .padding(.top, 10)
                    
                    if appState.isTripActive {
                        // Active Trip Card
                        VStack(spacing: 24) {
                            HStack {
                                Circle()
                                    .fill(BohoColors.safeGreen)
                                    .frame(width: 8, height: 8)
                                Text("LIVE")
                                    .font(.system(size: 12, weight: .black))
                                    .foregroundColor(BohoColors.safeGreen)
                                Spacer()
                                Text(appState.tripStartTime?.formatted(date: .omitted, time: .shortened) ?? "")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(BohoColors.textSecondary)
                            }
                            
                            VStack(spacing: 4) {
                                Text(formatTime(appState.elapsedTime))
                                    .font(.system(size: 56, weight: .black, design: .monospaced))
                                    .foregroundColor(BohoColors.textPrimary)
                                
                                Text("DURATION")
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(BohoColors.textTertiary)
                                    .tracking(1.5)
                            }
                            
                            HStack(spacing: 40) {
                                StatView(label: "PASSENGERS", value: "\(appState.currentPassengers)", icon: "person.2.fill")
                                StatView(label: "STATUS", value: "SECURE", icon: "checkmark.shield.fill")
                            }
                            
                            PrimaryButton(title: "End Trip", icon: "flag.checkered", isEnabled: true) {
                                appState.endTrip()
                            }
                        }
                        .padding(24)
                        .glassCard()
                        .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
                    // History Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("PAST TRIPS")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(BohoColors.textSecondary)
                            .tracking(1.5)
                        
                        if appState.tripHistory.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "clock.arrow.circlepath")
                                    .font(.system(size: 40))
                                    .foregroundColor(BohoColors.textTertiary.opacity(0.3))
                                Text("No trip history yet")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(BohoColors.textTertiary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                        } else {
                            VStack(spacing: 12) {
                                ForEach(appState.tripHistory) { trip in
                                    HistoryCard(trip: trip)
                                }
                            }
                        }
                    }
                    
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
        .animation(.spring(), value: appState.isTripActive)
    }
    
    private func formatTime(_ seconds: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: seconds) ?? "00:00:00"
    }
}

struct StatView: View {
    let label: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 16))
                .foregroundColor(BohoColors.terracotta)
            Text(value)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(BohoColors.textPrimary)
            Text(label)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(BohoColors.textTertiary)
        }
    }
}

struct HistoryCard: View {
    let trip: TripRecord
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(trip.formattedDate)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(BohoColors.textPrimary)
                Text(trip.formattedTime)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(BohoColors.textTertiary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(trip.formattedDuration)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundColor(BohoColors.textPrimary)
                HStack(spacing: 4) {
                    Image(systemName: "person.2.fill")
                        .font(.system(size: 10))
                    Text("\(trip.passengerCount) psgrs")
                        .font(.system(size: 12, weight: .semibold))
                }
                .foregroundColor(BohoColors.textSecondary)
            }
        }
        .padding(20)
        .glassCard(cornerRadius: 18)
    }
}
