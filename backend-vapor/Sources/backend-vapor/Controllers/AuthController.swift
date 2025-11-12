//
//  Untitled.swift
//  backend-vapor
//
//  Created by Pratama One on 11/11/25.
//

import Vapor
import JWT

struct AuthController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let auth = routes.grouped("api")
        
        auth.post(use: self.login)
        
        // JWT Protect
        let protected = auth.grouped(JWTMiddleware())
        protected.get(use: self.me)
    }
    
    // -> POST Request /api/login (login and get some token
    @Sendable
    func login(_ req: Request) async throws -> LoginResponse {
        let body = try req.content.decode(LoginRequest.self)
        
        // TODO
        guard body.email == "admin@sensus.local", body.password == "admin123" else {
            throw Abort(.unauthorized, reason: "Email atau password salah")
        }
        
        let expireSeconds = 60 * 60 * 24 * 5
        let expiration = ExpirationClaim(
            value: .init(timeIntervalSinceNow: TimeInterval(expireSeconds))
        )
        
        // Payload JWT
        let payload = UserPayload(
            subject: .init(value: "1"),
            expiration: expiration,
            name: "Admin",
            email: body.email,
            role: "admin"
        )
        
        // Generate token
        let token = try await req.jwt.sign(payload)
        
        return LoginResponse(
            token: token,
            tokenType: "Bearer",
            expiresIn: expireSeconds
        )
    }
    
    // -> GET /api/me (Cek token validation
    @Sendable
    func me(_ req: Request) async throws -> UserPayload {
        let payload = try req.userPayload
        
        return payload
    }
}
