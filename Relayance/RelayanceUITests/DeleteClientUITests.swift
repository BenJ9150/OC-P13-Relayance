//
//  DeleteClientUITests.swift
//  RelayanceUITests
//
//  Created by Benjamin LEFRANCOIS on 11/04/2025.
//

import XCTest

final class DeleteClientUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: Delete client

    func testGivenOnDetailPage_WhenClickOnDeleteButton_ThenGoBackAndClientIsNoLongerInTheList() {
        // Given
        let client = app.staticTexts["Frida Kahlo"]
        XCTAssertTrue(client.exists)
        client.tap()

        // When
        app.buttons["Supprimer"].tap()

        // Then detail view is closed
        XCTAssertTrue(app.staticTexts["Liste des clients"].waitForExistence(timeout: 2))

        // And client doesn't exist on home View
        XCTAssertFalse(client.exists)
    }
}
