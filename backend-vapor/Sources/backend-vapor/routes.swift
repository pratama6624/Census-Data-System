import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.routes.caseInsensitive = true
    app.http.client.configuration.redirectConfiguration = .disallow
    
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    try app.register(collection: TodoController())
    
    // Routes Auth
    try app.register(collection: AuthController())
    
}
