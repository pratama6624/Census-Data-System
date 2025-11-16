//
//  SeedCitiesMigration.swift
//  backend-vapor
//
//  Created by Pratama One on 16/11/25.
//

import Fluent
import Foundation
import Crypto
import Vapor

struct SeedCitiesMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        var cities: [Cities] = []
        
        let regions = [
            "Jakarta Selatan",
            "Semarang",
            "Bandung",
            "Jambi",
            "Surabaya",
            "Tangerang Selatan",
            "Malang",
            "Solo"
        ]

        
        for i in 0..<regions.count {
            let city = Cities(
                id: UUID(),
                name: regions[i]
            )
            cities.append(city)
        }
        
        try await cities.create(on: database)
    }
    
    func revert(on database: any Database) async throws {
        try await Cities.query(on: database).delete()
    }
}
