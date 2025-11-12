//
//  LoginResponse.swift
//  backend-vapor
//
//  Created by Pratama One on 12/11/25.
//

import Vapor

struct LoginResponse: Content {
    let token: String
    let tokenType: String
    let expiresIn: Int
}
