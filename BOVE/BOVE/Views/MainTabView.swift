//
//  MainTabView.swift
//  BOVE
//
//  Root navigation for the Boat Safety app with a modern glass tab bar.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var appState = AppState()
    @State private var selectedTab: Tab = .dashboard
    
    enum Tab {
        case dashboard
        case trips
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .dashboard:
                    DashboardView(appState: appState)
                case .trips:
                    TripView(appState: appState)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Custom Glass Tab Bar
            HStack(spacing: 0) {
                TabItem(icon: "helm", label: "Dashboard", isSelected: selectedTab == .dashboard) {
                    selectedTab = .dashboard
                }
                
                TabItem(icon: "list.bullet.rectangle", label: "Trips", isSelected: selectedTab == .trips) {
                    selectedTab = .trips
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 16)
            .padding(.bottom, 34)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .overlay(
                        VStack {
                            Divider()
                            Spacer()
                        }
                    )
            )
            .ignoresSafeArea()
        }
        .onChange(of: appState.isTripActive) { isActive in
            if isActive {
                withAnimation {
                    selectedTab = .trips
                }
            }
        }
    }
}

struct TabItem: View {
    let icon: String
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: isSelected ? .bold : .medium))
                    .foregroundColor(isSelected ? BohoColors.terracotta : BohoColors.textTertiary)
                    .shadow(color: isSelected ? BohoColors.terracotta.opacity(0.3) : .clear, radius: 8)
                
                Text(label)
                    .font(.system(size: 10, weight: isSelected ? .bold : .semibold))
                    .foregroundColor(isSelected ? BohoColors.terracotta : BohoColors.textTertiary)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    MainTabView()
}
