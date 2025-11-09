import NIOSSL
import Fluent
import FluentMySQLDriver
import Vapor
import JWT
import JWTKit

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(DatabaseConfigurationFactory.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? MySQLConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .mysql)
    
    // Ambil secret dari .env (kalau belum ada pakai default dev)
    let secret = Environment.get("JWT_SECRET") ?? "dev-secret-change-me"

    // Daftarkan HS256 key ke JWT (convert String to HMACKey)
    let hmacKey = HMACKey(from: Data(secret.utf8))
    await app.jwt.keys.add(hmac: hmacKey, digestAlgorithm: .sha256)

    app.migrations.add(CreateTodo())

    // register routes
    try routes(app)
}
