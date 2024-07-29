import NIOSSL
import Fluent
import FluentMySQLDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    var tls = TLSConfiguration.makeClientConfiguration()
    tls.certificateVerification = .none
    app.databases.use(DatabaseConfigurationFactory.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? MySQLConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "root",
        password: Environment.get("DATABASE_PASSWORD") ?? "123",
        database: Environment.get("DATABASE_NAME") ?? "vapor",
        tlsConfiguration: tls,
        maxConnectionsPerEventLoop:1
    ), as: .mysql)
    app.migrations.add(CreatUser())
    app.migrations.add(CreateTodo())
    app.middleware = .init()
    app.middleware.use(ResponseErrorMiddleware())    
    try await app.autoMigrate()
    // register routes
    try routes(app)
}
