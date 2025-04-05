//
//  ClientViewModelTests.swift
//  RelayanceTests
//
//  Created by Benjamin LEFRANCOIS on 05/04/2025.
//

import XCTest
@testable import Relayance

@MainActor final class ClientViewModelTests: XCTestCase {

    // MARK: Init

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
