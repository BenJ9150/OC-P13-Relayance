//
//  ClientViewModelTests.swift
//  RelayanceTests
//
//  Created by Benjamin LEFRANCOIS on 05/04/2025.
//

import XCTest
@testable import Relayance

@MainActor final class ClientViewModelTests: XCTestCase {

    private var viewModel: ClientViewModel!

    // MARK: Setup

    override func setUp() {
        super.setUp()
        let jsonFile = "MockValidClients.json"
        viewModel = ClientViewModel(clientsFile: jsonFile, fromBundle: Bundle(for: ClientViewModelTests.self))
    }
}

// MARK: Init

extension ClientViewModelTests {

    func testGivenValidJsonFile_WhenLoadingClientsList_ThenReturnsNonEmptyArray() throws {
        // Given
        let jsonFile = "MockValidClients.json"

        // When
        let viewModel = ClientViewModel(clientsFile: jsonFile, fromBundle: Bundle(for: ClientViewModelTests.self))

        // Then
        XCTAssertTrue(viewModel.clientsList.count > 0)
        XCTAssertTrue(viewModel.clientsListLoadError.isEmpty)
    }

    func testGivenInvalidJsonFile_WhenLoadingClientsList_ThenThereIsAnErrorMessage() throws {
        // Given
        let jsonFile = "MockInvalidClients.json"

        // When
        let viewModel = ClientViewModel(clientsFile: jsonFile, fromBundle: Bundle(for: ClientViewModelTests.self))

        // Then
        XCTAssertTrue(viewModel.clientsList.count == 0)
        XCTAssertTrue(viewModel.clientsListLoadError != "")
    }
}

// MARK: Add client

extension ClientViewModelTests {

    func testGivenOnAddClientPage_WhenFieldsAreIncompleteAndClickOnAddButton_ThenShowError() {
        // Given
        viewModel.showAddClientView = true
        XCTAssertTrue(viewModel.nameError.isEmpty)
        XCTAssertTrue(viewModel.emailError.isEmpty)

        // When
        viewModel.name = ""
        viewModel.email = ""

        // And
        viewModel.addClient()

        // Then
        XCTAssertEqual(viewModel.nameError, RelayanceError.emptyField.description)
        XCTAssertEqual(viewModel.emailError, RelayanceError.emptyField.description)
        XCTAssertTrue(viewModel.showAddClientView)
    }
}
