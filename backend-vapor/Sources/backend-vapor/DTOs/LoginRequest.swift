//
//  LoginRequest.swift
//  backend-vapor
//
//  Created by Pratama One on 12/11/25.
//

import Vapor

struct LoginRequest: Content {
    let email: String
    let password: String
}
