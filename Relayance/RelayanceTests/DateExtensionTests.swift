//
//  DateExtensionTests.swift
//  RelayanceTests
//
//  Created by Benjamin LEFRANCOIS on 04/04/2025.
//

import XCTest
@testable import Relayance

final class DateExtensionTests: XCTestCase {

    // MARK: Date from string

    func testGivenValidIsoString_WhenParsingToDate_ThenDateIsValid() {
        // Given
        let stringWithoutFractionalSec = "2023-02-20T09:15:00Z"
        let stringWithFractionalSec = "2023-02-20T09:15:00.122Z"

        // When
        let dateWithoutFractionalSec = Date.dateFromString(stringWithoutFractionalSec)
        let dateWithFractionalSec = Date.dateFromString(stringWithFractionalSec)

        // Then
        XCTAssertEqual(dateWithoutFractionalSec!.timeIntervalSince1970, 1676884500)
        XCTAssertEqual(dateWithFractionalSec!.timeIntervalSince1970, 1676884500.122)
    }

    func testGivenInvalidIsoString_WhenParsingToDate_ThenDateIsNil() {
        // Given
        let invalidStringDate = "2023-02-20"

        // When
        let date = Date.dateFromString(invalidStringDate)

        // Then
        XCTAssertNil(date)
    }
}

// MARK: String from date

extension DateExtensionTests {

    func testGivenFirstMarch2025Date_WhenParsingToString_ThenStringDateIs01032025() {
        // Given
        var components = DateComponents()
        components.day = 1
        components.month = 3
        components.year = 2025
        let date = Calendar.current.date(from: components)!

        // When
        let stringDate = Date.stringFromDate(date)

        // Then
        XCTAssertEqual(stringDate, "01-03-2025")
    }

    func testGivenTenthNovember2025Date_WhenParsingToString_ThenStringDateIs10112025() {
        // Given
        var components = DateComponents()
        components.day = 10
        components.month = 11
        components.year = 2025
        let date = Calendar.current.date(from: components)!

        // When
        let stringDate = Date.stringFromDate(date)

        // Then
        XCTAssertEqual(stringDate, "10-11-2025")
    }
}

// MARK: Get day

extension DateExtensionTests {

    func testGivenFirstMarch2025Date_WhenGettingDay_ThenReturns1() {
        // Given
        let dateComponents = DateComponents(year: 2025, month: 3, day: 1)
        let calendar = Calendar.current
        let testDate = calendar.date(from: dateComponents)!

        // When
        let day = testDate.getDay()

        // Then
        XCTAssertEqual(day, 1)
    }

    func testGivenTenthNovember2025Date_WhenGettingDay_ThenReturns10() {
        // Given
        let dateComponents = DateComponents(year: 2025, month: 11, day: 10)
        let calendar = Calendar.current
        let testDate = calendar.date(from: dateComponents)!

        // When
        let day = testDate.getDay()

        // Then
        XCTAssertEqual(day, 10)
    }
}

// MARK: Get month

extension DateExtensionTests {

    func testGivenFirstMarch2025Date_WhenGettingMonth_ThenReturns3() {
        // Given
        let dateComponents = DateComponents(year: 2025, month: 3, day: 1)
        let calendar = Calendar.current
        let testDate = calendar.date(from: dateComponents)!

        // When
        let month = testDate.getMonth()

        // Then
        XCTAssertEqual(month, 3)
    }

    func testGivenTenthNovember2025Date_WhenGettingMonth_ThenReturns11() {
        // Given
        let dateComponents = DateComponents(year: 2025, month: 11, day: 10)
        let calendar = Calendar.current
        let testDate = calendar.date(from: dateComponents)!

        // When
        let month = testDate.getMonth()

        // Then
        XCTAssertEqual(month, 11)
    }
}

// MARK: Get year

extension DateExtensionTests {

    func testGivenFirstMarch2024Date_WhenGettingYear_ThenReturns2024() {
        // Given
        let dateComponents = DateComponents(year: 2024, month: 3, day: 1)
        let calendar = Calendar.current
        let testDate = calendar.date(from: dateComponents)!

        // When
        let year = testDate.getYear()

        // Then
        XCTAssertEqual(year, 2024)
    }

    func testGivenTenthNovember2025Date_WhenGettingYear_ThenReturns2025() {
        // Given
        let dateComponents = DateComponents(year: 2025, month: 11, day: 10)
        let calendar = Calendar.current
        let testDate = calendar.date(from: dateComponents)!

        // When
        let year = testDate.getYear()

        // Then
        XCTAssertEqual(year, 2025)
    }
}
