# NoVaporApp

NoVaporApp is a Swift framework designed to facilitate the creation of server applications using Vapor. It provides a set of default implementations for common features, making it easier to set up and develop new server apps.

## Features

- User authentication
- Client app management
- Sign-in functionality
- MongoDB integration

## Installation

Add the following dependency to your `Package.swift` file:

```swift
.package(url: "https://github.com/ultim8p/loomiolampmark1.git", branch: "main")
```

## Usage

### Initializing NoVaporApp

```swift
import Vapor
import NoVaporApp

let app = Application(.development)
let noVaporApp = NoVaporApp(appId: "server.identifier", app: app)
```

### Setting up Authentication Routes

```swift
noVaporApp.registerAuthRoutes(app.routes)
```

### Adding User Sign-In

```swift
let serverRepo = ServerRepo(
    baseURL: "https://sigin.com",
    key: "noSignInServerAPIKey",
    credentials:  ClientCredentials(
        _id: ObjectId("credentialsIdInSignInServer"),
        publicKey: "SignInServerPubKey",
        otpKey: "SignInServerOTPKey"
    ),
    identifier: "com.signin"
)

noVaporApp.addUserSignIn(serverRepo: serverRepo, authRoutes: noVaporApp.authRoutes!)
```

## Key Components

### ClientApp

Represents a client application that can use your server.

To create a new ClientApp:

Call only once to create origin credentials
```swift
try await String.noAuthGenerateOriginCredentials(in: app.mongoDB)
```

Call only once to create client app credentials
```swift
let appService = ClientAppService()
let ap = ClientApp(identifier: "com.client.app" || "client.app")
try await appService.createApp(db: app.mongoDB, app: ap, serverId: Default.appIdentifier)
```

### User

Represents a user of your application.

```swift
let user = try User.build()
```

### AppUser

Represents the relationship between a user and a client app.

```swift
try await AppUser.ensureExists(db: db, app: clientApp, user: user)
```

### NoSignInService

Handles the sign-in process.

```swift
let signInService = NoSignInService(appId: "your.app.id", client: app.client, serverRepo: serverRepo)
let result = try await signInService.signIn(db: db, app: clientApp, request: signInRequest, headers: headers)
```

## Error Handling

The framework uses `NoError` for error handling. You can create custom errors like this:

```swift
NoError.noVaporAppError(reason: "Your error reason", code: .yourErrorCode)
```

## Middleware

The framework includes `AuthCredentialsMiddleware` for handling authentication. It's automatically set up when you call `registerAuthRoutes(_:)`.

## Controllers

- `NoSignInController`: Handles sign-in routes
- `ServerSignInController`: Handles server-side sign-in routes
