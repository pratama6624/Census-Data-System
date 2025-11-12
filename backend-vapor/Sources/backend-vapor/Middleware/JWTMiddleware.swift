//
//  JWTMiddleware.swift
//  backend-vapor
//
//  Created by Pratama One on 12/11/25.
//

import Vapor
import JWT

private struct UserPayloadKey: StorageKey {
    typealias Value = UserPayload
}

struct JWTMiddleware: AsyncMiddleware {
    func respond(
        to req: Request,
        chainingTo next: any AsyncResponder
    ) async throws -> Response {
        let payload = try await req.jwt.verify(as: UserPayload.self)
        
        req.storage[UserPayloadKey.self] = payload
        
        return try await next.respond(to: req)
    }
}

extension Request {
    var userPayload: UserPayload {
        get throws {
            guard let payload = storage[UserPayloadKey.self] else {
                throw Abort(.unauthorized, reason: "User payload not found in request")
            }
            return payload
        }
    }
}
