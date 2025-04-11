//
//  RelayanceError.swift
//  Relayance
//
//  Created by Benjamin LEFRANCOIS on 11/04/2025.
//

import Foundation

enum RelayanceError {

    case emptyField

    var description: String {
        switch self {
        case .emptyField:
            return "Ce champ est obligatoire."
        }
    }
}
