//
//  Cities.swift
//  backend-vapor
//
//  Created by Pratama One on 16/11/25.
//

import Vapor
import Fluent

final class Cities: Model, @unchecked Sendable {
    static let schema: String = "cities"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Timestamp(key: "created_at", on: .create)
    var created_at: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updated_at: Date?
    
    init() {}
    
    init(id: UUID? = nil, name: String, created_at: Date = Date(), updated_at: Date = Date()) {
        self.id = id
        self.name = name
        self.created_at = created_at
        self.updated_at = updated_at
    }
}
