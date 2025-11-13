//
//  Untitled.swift
//  backend-vapor
//
//  Created by Pratama One on 11/11/25.
//

import Vapor
import Fluent
import JWT
import Crypto

struct AuthController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let auth = routes.grouped("api")
        
        auth.post("login", use: self.login)
        
        // JWT Protect
        let protected = auth.grouped(JWTMiddleware())
        protected.get("me", use: self.me)
    }
    
    // -> POST Request /api/login (login and get some token
    @Sendable
    func login(_ req: Request) async throws -> ApiResponse<LoginData> {
        let body = try req.content.decode(LoginRequest.self)
        
        guard let user = try await User.query(on: req.db)
            .filter(\.$email == body.email)
                .first() else {
            throw Abort(.unauthorized, reason: "User not found")
        }
        
        guard try await req.password.async.verify(body.password, created: user.password) else {
            throw Abort(.unauthorized, reason: "Password salah")
        }
        
        let expiresIn = 60 * 60 * 24 * 5
            let expiration = ExpirationClaim(value: .init(timeIntervalSinceNow: TimeInterval(expiresIn)))

            let payload = UserPayload(
                subject: .init(value: user.id?.uuidString ?? ""),
                expiration: expiration,
                name: user.name,
                email: user.email,
                role: user.role
            )

        let token = try await req.jwt.sign(payload)

        let data = LoginData(
            token: token,
            token_type: "Bearer",
            expires_in: expiresIn,
            user: UserDTO(
                id: user.id?.uuidString ?? "",
                name: user.name,
                email: user.email,
                role: user.role
            )
        )

        return ApiResponse(status: true, message: "Login success", data: data)
    }
    
    // -> GET /api/me (Cek token validation
    @Sendable
    func me(_ req: Request) async throws -> UserPayload {
        let payload = try req.userPayload
        
        return payload
    }
}
