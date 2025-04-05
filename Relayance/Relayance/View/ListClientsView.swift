//
//  ListClientsView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct ListClientsView: View {
    @State var clientsList: [Client] = [] // OLD: = ModelData.chargement("Source.json")
    @State private var showModal: Bool = false
    
    var body: some View {
        NavigationStack {
            List(clientsList, id: \.self) { client in
                NavigationLink {
                    DetailClientView(client: client)
                } label: {
                    Text(client.nom)
                        .font(.title3)
                }
            }
            .navigationTitle("Liste des clients")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ajouter un client") {
                        showModal.toggle()
                    }
                    .foregroundStyle(.orange)
                    .bold()
                }
            }
            .sheet(isPresented: $showModal, content: {
                AjoutClientView(dismissModal: $showModal)
            })
        }
        // NEW: load source.json that can throw
        .onAppear {
            loadSource()
        }
    }

    private func loadSource() {
        guard clientsList.isEmpty else { return }
        clientsList = (try? ModelData.chargement("Source.json") as [Client]) ?? []
    }
}

#Preview {
    ListClientsView()
}
