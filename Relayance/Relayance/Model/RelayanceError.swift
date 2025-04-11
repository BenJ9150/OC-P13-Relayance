//
//  RelayanceError.swift
//  Relayance
//
//  Created by Benjamin LEFRANCOIS on 11/04/2025.
//

import Foundation

enum RelayanceError {

    case emptyField
    case invalidEmail
    case emailAlreadyExists(clientName: String)

    var description: String {
        switch self {
        case .emptyField: return "Ce champ est obligatoire."
        case .invalidEmail: return "Le format de l'email est invalide."
        case .emailAlreadyExists(let name): return "Cet email est déjà utilisé par \(name)."
        }
    }
}
