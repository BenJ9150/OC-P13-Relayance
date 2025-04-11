//
//  DetailClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct DetailClientView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ClientViewModel

    var client: Client
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundStyle(.orange)
                .padding(50)
            Spacer()
            Text(client.nom)
                .font(.title)
                .padding()
            Text(client.email)
                .font(.title3)
            Text(client.formatDateVersString())
                .font(.title3)
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Supprimer") {
                    // suppression
                    viewModel.delete(client)
                    dismiss()
                }
                .foregroundStyle(.red)
                .bold()
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = ClientViewModel()
    let client = Client.creerNouveauClient(nom: "tata", email: "tata@email")
    DetailClientView(viewModel: viewModel, client: client)
}
