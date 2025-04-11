//
//  RelayanceUITests.swift
//  RelayanceUITests
//
//  Created by Amandine Cousin on 08/07/2024.
//

import XCTest

final class RelayanceUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    func testErrorDecodingJsonData() {
        // Given
        let app = XCUIApplication()
        app.launchArguments.append("--ui_testing_json_error")

        // When
        app.launch()

        // Then
        XCTAssertTrue(app.staticTexts["Oups, une erreur est survenue lors du chargement des clients."].exists)
    }
}
