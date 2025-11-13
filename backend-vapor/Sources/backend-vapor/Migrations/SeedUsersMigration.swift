//
//  SeedUsersMigration.swift
//  backend-vapor
//
//  Created by Pratama One on 13/11/25.
//

import Fluent
import Foundation
import Crypto
import Vapor

struct SeedUsersMigration: AsyncMigration {
    func prepare(on database: any Database) async throws {
        var users: [User] = []
        
        for i in 1...200 {
            let hashed = try Bcrypt.hash("password\(i)")
            let user = User(
                id: UUID(),
                name: "User \(i)",
                email: "user\(i)@sensus.local",
                password: hashed,
                role: i == 1 ? "admin" : "user"
            )
            users.append(user)
        }
        
        try await users.create(on: database)
    }
    
    func revert(on database: any Database) async throws {
        try await User.query(on: database).delete()
    }
}
