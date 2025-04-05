//
//  ClientTests.swift
//  RelayanceTests
//
//  Created by Benjamin LEFRANCOIS on 04/04/2025.
//

import XCTest
@testable import Relayance

final class ClientTests: XCTestCase {

    // MARK: Private

    private let testName = "test"
    private let testEmail = "test@test.com"

    private func createClient(isoString: String) -> Client {
        Client(nom: testName, email: testEmail, dateCreationString: isoString)
    }

    private func createClient(isNew: Bool) -> Client {
        let date = isNew ? Date.now : Calendar.current.date(byAdding: .day, value: -1, to: Date())!

        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        return createClient(isoString: dateFormatter.string(from: date))
    }
}

// MARK: Init

extension ClientTests {

    func testGivenValidCreationDate_WhenCreatingClient_ThenClientIsValid() {
        // Given
        let dateCreationString = "2023-02-20T09:15:00Z"

        // When
        let client = createClient(isoString: dateCreationString)

        // Then
        XCTAssertEqual(client.nom, testName)
        XCTAssertEqual(client.email, testEmail)
        XCTAssertEqual(client.dateCreation.ISO8601Format(), dateCreationString)
    }

    func testGivenInvalidCreationDate_WhenCreatingClient_ThenCreationDateIsNow() {
        // Given
        let dateCreationString = "2023-20"

        // When
        let client = createClient(isoString: dateCreationString)

        // Then
        XCTAssertEqual(client.nom, testName)
        XCTAssertEqual(client.email, testEmail)
        XCTAssertLessThanOrEqual(abs(Date.now.timeIntervalSince(client.dateCreation)), 0.01)
    }
}

// MARK: Create client

extension ClientTests {

    func testGivenValidNameAndMail_WhenCreatingClient_ThenClientIsValid() {
        // Given
        let name = testName
        let email = testEmail

        // When
        let client = Client.creerNouveauClient(nom: name, email: email)
        
        // Then
        XCTAssertEqual(client.nom, testName)
        XCTAssertEqual(client.email, testEmail)
        XCTAssertLessThanOrEqual(abs(Date.now.timeIntervalSince(client.dateCreation)), 0.01)
    }
}

// MARK: Is new client

extension ClientTests {

    func testGivenClientJustCreated_WhenCheckingIfNew_ThenReturnsTrue() {
        // Given
        let client = createClient(isNew: true)

        // When
        let isNew = client.estNouveauClient()

        // Then
        XCTAssertTrue(isNew)
    }

    func testGivenClientCreatedYesterday_WhenCheckingIfNew_ThenReturnsFalse() {
        // Given
        let client = createClient(isNew: false)

        // When
        let isNew = client.estNouveauClient()

        // Then
        XCTAssertFalse(isNew)
    }
}

// MARK: Client exist

extension ClientTests {

    func testGivenClientsListContainClient_WhenCheckingIfTargetClientExist_ThenReturnsTrue() {
        // Given
        let targetClient = createClient(isNew: true)
        let clientList = [targetClient, createClient(isNew: false)]

        // When
        let exist = targetClient.clientExiste(clientsList: clientList)

        // Then
        XCTAssertTrue(exist)
    }

    func testGivenClientsListNotContainClient_WhenCheckingIfTargetClientExist_ThenReturnsFalse() {
        // Given
        let targetClient = createClient(isNew: true)
        let clientList = [createClient(isNew: false), createClient(isNew: false)]

        // When
        let exist = targetClient.clientExiste(clientsList: clientList)

        // Then
        XCTAssertFalse(exist)
    }
}

// MARK: Date to string

extension ClientTests {

    func testGivenClientCreated_WhenGettingStringDate_ThenStringDateHasValidFormat() {
        // Given
        let client = createClient(isoString: "2023-02-20T09:15:00Z")
        
        // When
        let stringDate = client.formatDateVersString()

        // Then
        XCTAssertEqual(stringDate, "20-02-2023")
    }

    func testGivenClientCreatedWithFractionalSec_WhenGettingStringDate_ThenStringDateHasValidFormat() {
        // Given
        let client = createClient(isoString: "2023-02-20T09:15:00.123Z")
        
        // When
        let stringDate = client.formatDateVersString()

        // Then
        XCTAssertEqual(stringDate, "20-02-2023")
    }
}
