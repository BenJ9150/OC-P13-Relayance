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

    @Published var nom: String = ""
    @Published var email: String = ""

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
            clientsListLoadError = "Oups, une erreur est survenue lors du chargement des clients."
        }
    }
}
