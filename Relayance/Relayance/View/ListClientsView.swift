//
//  ListClientsView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct ListClientsView: View {
    @StateObject var viewModel = ClientViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.clientsListLoadError.isEmpty {
                    /// Display clients list
                    List(viewModel.clientsList, id: \.self) { client in
                        NavigationLink {
                            DetailClientView(client: client)
                        } label: {
                            Text(client.nom)
                                .font(.title3)
                        }
                    }
                } else {
                    /// Display error
                    Text(viewModel.clientsListLoadError)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
            .navigationTitle("Liste des clients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ajouter un client") {
                        viewModel.showAddClientView.toggle()
                    }
                    .foregroundStyle(.orange)
                    .bold()
                }
            }
            .sheet(isPresented: $viewModel.showAddClientView, content: {
                AjoutClientView(viewModel: viewModel)
            })
        }
    }
}

#Preview {
    ListClientsView()
}
