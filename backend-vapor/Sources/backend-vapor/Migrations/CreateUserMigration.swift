//
//  CreateUserMigration.swift
//  backend-vapor
//
//  Created by Pratama One on 13/11/25.
//

import Fluent

struct CreateUserMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("users")
            .field("id", .uuid, .identifier(auto: false))
            .field("name", .string, .required)
            .field("email", .string, .required)
            .unique(on: "email")
            .field("password", .string, .required)
            .field("role", .string, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("users").delete()
    }
}
