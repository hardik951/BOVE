//
//  TripModel.swift
//  BOVE
//
//  Data models for trip tracking and safety monitoring
//

import Foundation
import SwiftUI
import Combine

// MARK: - Trip Record
struct TripRecord: Identifiable {
    let id = UUID()
    let date: Date
    let duration: TimeInterval
    let passengerCount: Int
    let maxCapacity: Int
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    var formattedDuration: String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        }
        return "\(minutes)m"
    }
}

// MARK: - Safety Check Item
struct SafetyCheckItem: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    var isChecked: Bool
}

// MARK: - Capacity Status
enum CapacityStatus {
    case safe
    case warning
    case overload
    
    var color: Color {
        switch self {
        case .safe: return BohoColors.safeGreen
        case .warning: return BohoColors.warningOrange
        case .overload: return BohoColors.dangerRed
        }
    }
    
    var label: String {
        switch self {
        case .safe: return "Safe"
        case .warning: return "Near Capacity"
        case .overload: return "Overloaded"
        }
    }
}

// MARK: - App State
class AppState: ObservableObject {
    @Published var currentPassengers: Int = 5
    @Published var maxCapacity: Int = 12
    @Published var isTripActive: Bool = false
    @Published var tripStartTime: Date?
    @Published var elapsedTime: TimeInterval = 0
    
    @Published var safetyChecks: [SafetyCheckItem] = [
        SafetyCheckItem(title: "Life Jackets", icon: "lifepreserver", isChecked: false),
        SafetyCheckItem(title: "Weather Check", icon: "cloud.sun", isChecked: false),
        SafetyCheckItem(title: "Passengers Verified", icon: "person.badge.shield.checkmark", isChecked: false)
    ]
    
    @Published var tripHistory: [TripRecord] = [
        TripRecord(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, duration: 5400, passengerCount: 8, maxCapacity: 12),
        TripRecord(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, duration: 7200, passengerCount: 10, maxCapacity: 12),
        TripRecord(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, duration: 3600, passengerCount: 6, maxCapacity: 12),
        TripRecord(date: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, duration: 9000, passengerCount: 11, maxCapacity: 12),
        TripRecord(date: Calendar.current.date(byAdding: .day, value: -10, to: Date())!, duration: 4500, passengerCount: 4, maxCapacity: 12),
    ]
    
    var capacityStatus: CapacityStatus {
        let ratio = Double(currentPassengers) / Double(maxCapacity)
        if ratio > 1.0 { return .overload }
        if ratio >= 0.8 { return .warning }
        return .safe
    }
    
    var capacityProgress: Double {
        min(Double(currentPassengers) / Double(maxCapacity), 1.0)
    }
    
    var allChecksComplete: Bool {
        safetyChecks.allSatisfy { $0.isChecked }
    }
    
    var canStartTrip: Bool {
        allChecksComplete && capacityStatus != .overload && !isTripActive
    }
    
    private var timer: AnyCancellable?

    func startTrip() {
        isTripActive = true
        tripStartTime = Date()
        elapsedTime = 0
        
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, let start = self.tripStartTime else { return }
                self.elapsedTime = Date().timeIntervalSince(start)
            }
    }
    
    func endTrip() {
        timer?.cancel()
        timer = nil
        
        guard let startTime = tripStartTime else { return }
        let duration = Date().timeIntervalSince(startTime)
        let record = TripRecord(
            date: startTime,
            duration: duration,
            passengerCount: currentPassengers,
            maxCapacity: maxCapacity
        )
        tripHistory.insert(record, at: 0)
        isTripActive = false
        tripStartTime = nil
        elapsedTime = 0
        
        // Reset safety checks for next trip
        for i in safetyChecks.indices {
            safetyChecks[i].isChecked = false
        }
    }
}
