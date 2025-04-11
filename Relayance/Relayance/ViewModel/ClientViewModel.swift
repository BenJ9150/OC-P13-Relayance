//
//  ClientViewModel.swift
//  Relayance
//
//  Created by Benjamin LEFRANCOIS on 05/04/2025.
//

import SwiftUI

@MainActor class ClientViewModel: ObservableObject {

    // MARK: Client list properties

    @Published var clientsList: [Client] = []
    @Published var showAddClientView = false
    @Published var clientsListLoadError = ""

    // MARK: Add client properties

    @Published var name: String = ""
    @Published var email: String = ""
    @Published var nameError: String = ""
    @Published var emailError: String = ""

    // MARK: Init

    init(clientsFile: String = "Source.json", fromBundle bundle: Bundle = .main) {
        loadClients(clientsFile: clientsFile, from: bundle)
    }
}

// MARK: Load clients

extension ClientViewModel {
    
    private func loadClients(clientsFile: String, from bundle: Bundle) {
        clientsListLoadError = ""
        do {
            clientsList = try ModelData.chargement(clientsFile, from: bundle) as [Client]
        } catch {
            clientsListLoadError = RelayanceError.loadingJsonSourceFailed.description
        }
    }
}

// MARK: Add client

extension ClientViewModel {
    
    func addClient() {
        guard fieldsNotEmpty(), isValidEmail(), emailIsNew() else {
            return
        }
        clientsList.append(Client.creerNouveauClient(nom: name, email: email))
        showAddClientView = false
    }

    private func fieldsNotEmpty() -> Bool {
        nameError = name.isEmpty ? RelayanceError.emptyField.description : ""
        emailError = email.isEmpty ? RelayanceError.emptyField.description : ""
        return nameError.isEmpty && emailError.isEmpty
    }

    private func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let isValid = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
        emailError = isValid ? "" : RelayanceError.invalidEmail.description
        return isValid
    }

    private func emailIsNew() -> Bool {
        if let client = clientsList.first(where: { $0.email == email }) {
            emailError = RelayanceError.emailAlreadyExists(clientName: client.nom).description
            return false
        }
        emailError = ""
        return true
    }
}

// MARK: Delete client

extension ClientViewModel {
    
    func delete(_ client: Client) {
        clientsList.removeAll(where: { $0 == client })
    }
}
