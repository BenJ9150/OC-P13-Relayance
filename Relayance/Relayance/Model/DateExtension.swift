//
//  DateExtension.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

extension Date {

    static func dateFromString(_ isoString: String) -> Date? {
        /// Try to get date with fractional seconds
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoDateFormatter.date(from: isoString) {
            return date
        }
        /// Try to get date without fractional seconds
        isoDateFormatter.formatOptions = [.withInternetDateTime]
        return isoDateFormatter.date(from: isoString)
    }
    
    static func stringFromDate(_ date: Date) -> String {
        let isoDateFormatter = DateFormatter()
        isoDateFormatter.dateFormat = "dd-MM-yyyy"
        
        return isoDateFormatter.string(from: date)
    }
    
    func getDay() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func getMonth() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    func getYear() -> Int {
        return Calendar.current.component(.year, from: self)
    }
    
}
