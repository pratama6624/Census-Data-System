//
//  CreateCitiesMigration.swift
//  backend-vapor
//
//  Created by Pratama One on 14/11/25.
//

import Fluent

struct CreateCitiesMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("cities")
            .field("id", .uuid, .identifier(auto: false))
            .field("name", .string, .required)
            .field("created_at", .datetime)
            .field("updated_at", .datetime)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("cities").delete()
    }
}
