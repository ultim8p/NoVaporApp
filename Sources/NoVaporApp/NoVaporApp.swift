// The Swift Programming Language
// https://docs.swift.org/swift-book

import Vapor
import NoServerAuth
import NoMongo
import MongoKitten
import NoVaporError

public final class NoVaporApp {
    
    // Server App Id: Ex: "cloud.noVaporApp"
    public let app: Application
    
    public var authMiddleware: AuthCredentialsMiddleware?
    
    public var authRoutes: RoutesBuilder?
    
    public let appId: String
    
    public var noSignInKit: NoSignInKit?
    
    public init(appId: String, app: Application) {
        self.appId = appId
        self.app = app
        
        app.middleware = .init()
        app.middleware.use(NoErrorMiddleware.default(environment: app.environment))
    }
    
    // App authentication is required
    public func registerAuthRoutes(_ routes: RoutesBuilder) {
        let authMiddleware = AuthCredentialsMiddleware(authClosure: handleAuthenticatedObject)
        self.authMiddleware = authMiddleware
        
        let authRoutes = routes.grouped(authMiddleware)
        self.authRoutes = authRoutes
        
        // Server Sign In
        let serverSignInController = ServerSignInController(appId: appId)
        serverSignInController.registerAuthRoutes(authRoutes)
    }
    
    public func addUserSignIn(serverRepo: ServerRepo, authRoutes: RoutesBuilder) {
        noSignInKit = NoSignInKit(appId: appId, client: app.client, serverRepo: serverRepo)
        noSignInKit?.registerAuthRoutes(authRoutes)
    }
}

// MARK: - Authentication middleware

public extension NoVaporApp {
    
    func handleAuthenticatedObject(_ request: Request, _ credentials: ServerCredentials) async throws {
        try await request.storeAuthentication(in: request.mongoDB, credentials: credentials)
    }
}

// MARK: - Request authentication storage

extension Request {
    
    func storeAuthentication(in db: MongoDatabase, credentials: ServerCredentials) async throws {
        guard let entity = credentials.entity,
              let type = AuthCredentialsType(rawValue: entity),
              let id = credentials.entityId
        else { throw NoError.noVaporAppError(reason: "Server credentials", code: .missingValues) }
        switch type {
        case .origin:
            break
        case .app:
            let app: ClientApp = try await ClientApp.findOne(in: db, id: id)
            authClientApp = app
        case .user:
            let user: User = try await User.findOne(in: db, id: id)
            authUser = user
        }
    }
}

