//
//  UserPayload.swift
//  backend-vapor
//
//  Created by Pratama One on 10/11/25.
//

import JWT
import Vapor

struct UserPayload: JWTPayload, Content {
    var subject: SubjectClaim
    var expiration: ExpirationClaim
    
    var name: String
    var email: String
    var role: String
    
    func verify(using: some JWTAlgorithm) async throws {
        try expiration.verifyNotExpired()
    }
}
