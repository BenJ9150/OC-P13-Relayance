//
//  AjoutClientView.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import SwiftUI

struct AjoutClientView: View {
    @ObservedObject var viewModel: ClientViewModel
    
    var body: some View {
        VStack {
            Text("Ajouter un nouveau client")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            textfield("Nom", text: $viewModel.name, error: viewModel.nameError)
            textfield("Email", text: $viewModel.email, error: viewModel.emailError)
            Button("Ajouter") {
                // Ajout d'un client
                viewModel.addClient()
            }
            .padding(.horizontal, 50)
            .padding(.vertical)
            .font(.title2)
            .bold()
            .background(RoundedRectangle(cornerRadius: 10).fill(.orange))
            .foregroundStyle(.white)
            .padding(.top, 50)
            Spacer()
        }
        .padding()
    }

    private func textfield(_ prompt: String, text: Binding<String>, error: String) -> some View {
        VStack {
            TextField(prompt, text: text)
                .font(.title2)
            if !error.isEmpty {
                Text("* \(error)")
                    .font(.caption)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var viewModel = ClientViewModel()
    AjoutClientView(viewModel: viewModel)
}
