//
//  User.swift
//  backend-vapor
//
//  Created by Pratama One on 13/11/25.
//

import Vapor
import Fluent

final class User: Model, @unchecked Sendable {
    static let schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "email")
    var email: String
        
    @Field(key: "password")
    var password: String
    
    @Field(key: "role")
    var role: String
    
    init() {}
    
    init(id: UUID? = nil, name: String, email: String, password: String, role: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.role = role
    }
}
