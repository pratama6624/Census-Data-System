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
        hostname: Environment.get("DATABASE_HOST") ?? "127.0.0.1",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? 3306,
        username: Environment.get("DATABASE_USERNAME") ?? "root",
        password: Environment.get("DATABASE_PASSWORD") ?? "",
        database: Environment.get("DATABASE_NAME") ?? "census_data_system_vapor"
    ), as: .mysql)
    
    // Ambil secret dari .env (kalau belum ada pakai default dev)
    let secret = Environment.get("JWT_SECRET") ?? "dev-secret-change-me"

    // Daftarkan HS256 key ke JWT (convert String to HMACKey)
    let hmacKey = HMACKey(from: Data(secret.utf8))
    await app.jwt.keys.add(hmac: hmacKey, digestAlgorithm: .sha256)
    
    // Migration
    app.migrations.add(CreateUserMigration())
    
    try app.autoMigrate().wait()

    // register routes
    try routes(app)
}
