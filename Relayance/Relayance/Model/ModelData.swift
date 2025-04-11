//
//  ModelData.swift
//  Relayance
//
//  Created by Amandine Cousin on 10/07/2024.
//

import Foundation

struct ModelData {
    static func chargement<T: Decodable>(_ nomFichier: String, from bundle: Bundle = .main) throws -> T {
#if DEBUG
        if CommandLine.arguments.contains("--ui_testing_json_error") {
            throw NSError()
        }
#endif
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
}
