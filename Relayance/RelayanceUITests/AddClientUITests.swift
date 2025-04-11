//
//  AddClientUITests.swift
//  RelayanceUITests
//
//  Created by Benjamin LEFRANCOIS on 11/04/2025.
//

import XCTest

final class AddClientUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    // MARK: Invalid textfields

    func testGivenOnAddClientPage_WhenFieldsAreIncompleteAndClickOnAddButton_ThenShowError() {
        // Given
        app.buttons["Ajouter un client"].tap()

        // When
        app.buttons["Ajouter"].tap()

        // Then
        let errorPredicate = NSPredicate(format: "label == '* Ce champ est obligatoire.'")
        let errors = app.staticTexts.matching(errorPredicate)
        XCTAssertEqual(errors.count, 2)

        // And sheet always presented
        XCTAssertTrue(app.staticTexts["Ajouter un nouveau client"].exists)
    }

    func testGivenOnAddClientPage_WhenEmailIsInvalidAndClickOnAddButton_ThenShowError() {
        // Given
        app.buttons["Ajouter un client"].tap()

        // When
        let nameField = app.textFields["Nom"]
        nameField.tap()
        nameField.typeText("test UI")

        let emailField = app.textFields["Email"]
        emailField.tap()
        emailField.typeText("testui.com")

        // And
        app.buttons["Ajouter"].tap()

        // Then
        XCTAssertTrue(app.staticTexts["* Le format de l'email est invalide."].exists)

        // And sheet always presented
        XCTAssertTrue(app.staticTexts["Ajouter un nouveau client"].exists)
    }

    func testGivenOnAddClientPage_WhenEmailAlreadyExistAndClickOnAddButton_ThenShowError() {
        // Given
        app.buttons["Ajouter un client"].tap()

        // When
        let nameField = app.textFields["Nom"]
        nameField.tap()
        nameField.typeText("test UI")

        let emailField = app.textFields["Email"]
        emailField.tap()
        emailField.typeText("frida.kahlo@example.com")

        // And
        app.buttons["Ajouter"].tap()

        // Then
        XCTAssertTrue(app.staticTexts["* Cet email est déjà utilisé par Frida Kahlo."].exists)

        // And sheet always presented
        XCTAssertTrue(app.staticTexts["Ajouter un nouveau client"].exists)
    }

    // MARK: Success

    func testGivenOnAddClientPage_WhenValidFieldsAndClickOnAddBtn_ThenGoBackAndNewClientIsInTheList() {
        XCUIDevice.shared.orientation = .portrait
        // Given
        app.buttons["Ajouter un client"].tap()

        // When
        let nomField = app.textFields["Nom"]
        nomField.tap()
        nomField.typeText("test UI")

        let emailField = app.textFields["Email"]
        emailField.tap()
        emailField.typeText("testui@test.com")

        // And
        app.buttons["Ajouter"].tap()

        // Then sheet is closed
        XCTAssertFalse(app.staticTexts["Ajouter un nouveau client"].exists)

        // And client exist
        let clientCell = app.cells.staticTexts["test UI"]
        let maxScrolls = 10
        var scrollCount = 0
        while !clientCell.exists && scrollCount < maxScrolls {
            app.swipeUp()
            scrollCount += 1
        }
        XCTAssertTrue(clientCell.isHittable)
    }
}
