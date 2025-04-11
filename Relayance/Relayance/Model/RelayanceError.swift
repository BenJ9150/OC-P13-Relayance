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

    var description: String {
        switch self {
        case .emptyField: return "Ce champ est obligatoire."
        case .invalidEmail: return "Le format de l'email est invalide."
        }
    }
}
