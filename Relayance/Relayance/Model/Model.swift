//
//  Model.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

struct Client: Codable, Hashable {
    var nom: String
    var email: String
    private var dateCreationString: String

    var dateCreation: Date {
        Date.dateFromString(dateCreationString) ?? Date.now
    }
    
    enum CodingKeys: String, CodingKey {
        case nom
        case email
        case dateCreationString = "date_creation"
    }
    
    /// Constructeur
    init(nom: String, email: String, dateCreationString: String) { //TODO: XCTest
        self.nom = nom
        self.email = email
        self.dateCreationString = dateCreationString
    }
    
    /// Fonctions
    static func creerNouveauClient(nom: String, email: String) -> Client { //TODO: XCTest
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        return Client(nom: nom, email: email, dateCreationString: dateFormatter.string(from: Date.now))
    }
    
    func estNouveauClient() -> Bool { //TODO: XCTest
        let aujourdhui = Date.now
        let dateCreation = self.dateCreation
        
        if aujourdhui.getYear() != dateCreation.getYear() ||
            aujourdhui.getMonth() != dateCreation.getMonth() ||
            aujourdhui.getDay() != dateCreation.getDay() {
            return false
        }
        return true
    }
    
    func clientExiste(clientsList: [Client]) -> Bool { //TODO: XCTest
        if clientsList.contains(where: { $0 == self }) {
            return true
        }
        return false
    }
    
    func formatDateVersString() -> String { //TODO: XCTest
        return Date.stringFromDate(self.dateCreation) ?? self.dateCreationString
    }
}
