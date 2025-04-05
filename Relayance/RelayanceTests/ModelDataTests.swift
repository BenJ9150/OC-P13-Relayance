//
//  ModelDataTests.swift
//  RelayanceTests
//
//  Created by Benjamin LEFRANCOIS on 05/04/2025.
//

import XCTest
@testable import Relayance

final class ModelDataTests: XCTestCase {

    func testGivenValidJsonFile_WhenLoadingClientsList_ThenReturnsNonEmptyArray() throws {
        // Given
        let jsonFile = "MockValidClients.json"

        // When
        let clientsList: [Client] = try ModelData.chargement(jsonFile, from: Bundle(for: ModelDataTests.self))

        // Then
        XCTAssertTrue(clientsList.count > 0)
    }

    func testGivenNoJsonFile_WhenLoadingClientsList_ThenExeptionIsThrown() {
        // Given
        let jsonFile = "invalid.json"

        do {
            // When
            _ = try ModelData.chargement(jsonFile, from: Bundle(for: ModelDataTests.self)) as [Client]
            XCTFail("ModelDataTests: catch block should to be executed")

        } catch let error as NSError {
            // Then
            XCTAssertEqual(error.domain, "ModelDataError")
            XCTAssertEqual(error.code, 1)
        }
    }

    func testGivenInvalidJsonFile_WhenLoadingClientsList_ThenExeptionIsThrown() {
        // Given
        let jsonFile = "MockInvalidClients.json"

        do {
            // When
            _ = try ModelData.chargement(jsonFile, from: Bundle(for: ModelDataTests.self)) as [Client]
            XCTFail("ModelDataTests: catch block should to be executed")

        } catch let error as NSError {
            // Then
            XCTAssertEqual(error.domain, "ModelDataError")
            XCTAssertEqual(error.code, 2)
        }
    }
}
