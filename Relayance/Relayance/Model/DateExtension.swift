//
//  DateExtension.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

extension Date {

    static func dateFromString(_ isoString: String) -> Date? { //TODO: XCTest
        /// Try to get date with fractional seconds
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = isoDateFormatter.date(from: isoString) {
            return date
        }
        /// Try to get date without fractional seconds
        isoDateFormatter.formatOptions = [.withInternetDateTime]
        return isoDateFormatter.date(from: isoString)
        
        // OLD:
        // let isoDateFormatter = ISO8601DateFormatter()
        // isoDateFormatter.formatOptions = [.withFullDate]
        // return isoDateFormatter.date(from: isoString)
    }
    
    static func stringFromDate(_ date: Date) -> String { //TODO: XCTest
        let isoDateFormatter = DateFormatter()
        isoDateFormatter.dateFormat = "dd-MM-yyyy"
        
        return isoDateFormatter.string(from: date)
    }
    
    func getDay() -> Int { //TODO: XCTest
        return Calendar.current.component(.day, from: self)
    }
    
    func getMonth() -> Int { //TODO: XCTest
        return Calendar.current.component(.month, from: self)
    }
    
    func getYear() -> Int { //TODO: XCTest
        return Calendar.current.component(.year, from: self)
    }
    
}
