//
//  LoginResponse.swift
//  backend-vapor
//
//  Created by Pratama One on 12/11/25.
//

import Vapor

struct UserDTO: Content {
    let id: String
    let name: String
    let email: String
    let role: String
}

struct LoginData: Content {
    let token: String
    let token_type: String
    let expires_in: Int
    let user: UserDTO
}

struct ApiResponse<T: Content>: Content {
    let status: Bool
    let message: String
    let data: T
}
