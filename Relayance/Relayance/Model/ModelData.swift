//
//  ModelData.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

struct ModelData {
    static func chargement<T: Decodable>(_ nomFichier: String, from bundle: Bundle = .main) throws -> T {
        guard let file = bundle.url(forResource: nomFichier, withExtension: nil) else {
            throw NSError(
                domain: "ModelDataError",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Impossible de trouver \(nomFichier) dans le bundle."]
            )
        }
        do {
            let data = try Data(contentsOf: file)
            return try JSONDecoder().decode(T.self, from: data)

        } catch {
            throw NSError(
                domain: "ModelDataError",
                code: 2,
                userInfo: [NSLocalizedDescriptionKey: "Impossible de charger ou parser \(nomFichier) depuis le bundle:\n\(error)"]
            )
        }
    }

    /* OLD:
    static func chargement<T: Decodable>(_ nomFichier: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: nomFichier, withExtension: nil)
        else {
            fatalError("Impossible de trouver \(nomFichier) dans le main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Impossible de charger \(nomFichier) depuis le main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Impossible de parser \(nomFichier) en tant que \(T.self):\n\(error)")
        }
    }
     */
}
