import Foundation


/// The user denied your app's authorization request or there
/// was an error during the process of authorizing your app.
///
/// Do not confuse this with `SpotifyAuthenticationError`.
///
/// See the [authorization process][1].
///
/// [1]: https://developer.spotify.com/documentation/general/guides/authorization-guide/#example-1:~:text=If%20the%20user%20does%20not%20accept,example%20https%3A%2F%2Fexample.com%2Fcallback%3Ferror%3Daccess_denied%26state%3DSTATE%2C%20contains%20the%20following%20parameters%3A
public struct SpotifyAuthorizationError: LocalizedError, Codable, Hashable {
    
    /// The reason authorization failed; for example: "access_denied".
    /// Use the `accessWasDenied` boolean property to check if the user
    /// denied access to your application.
    public let error: String
    /// The value of the state parameter supplied in the request.
    public let state: String?
    
    /// Returns `true` if `error` == "access_denied".
    /// Else, `false`.
    public var accessWasDenied: Bool {
        return error == "access_denied"
    }
    
    public var errorDescription: String? {
        var description = error
        if let state = state {
            description += ". State: '\(state)'"
        }
        return description
        
    }
    
}
