import Foundation

/// A namespace of HTTP Headers.
public enum Headers {
    
    /**
     Makes the bearer authorization header using the access token.
    
     This header must be present in all requests to the Spotify web API,
     except for those involved in retrieving refresh and/or access tokens
     and authorizing your application.
     
     See also `bearerAuthorizationAndContentTypeJSON`.
     
     ```
     ["Authorization": "Bearer \(accessToken)"]
     ```
     - Parameter accessToken: The access token from Spotify.
     */
    public static func bearerAuthorization(
        _ accessToken: String
    ) -> [String: String] {
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    
    /**
     The JSON Content-Type header. This tells the server that
     the body of the request is JSON.
     
     ```
     ["Content-Type": "application/json"]
     ```
     */
    public static let contentTypeJSON = [
        "Content-Type": "application/json"
    ]
    
    /**
     The bearer authorization and JSON Content-Type headers.
    
     The JSON Content-Type header tells the server that the body
     of the request is JSON. The authorization header is required for
     all requests to the Spotify web API other than those for
     authorizing/authenticating your application.
     
     Equivalent to `bearerAuthorization(accessToken) + contentTypeJSON`
     ```
     [
         "Authorization": "Bearer \(accessToken)",
         "Content-Type": "application/json"
     ]
     ```
     
     - Parameter accessToken: The access token from Spotify.
     */
    public static func bearerAuthorizationAndContentTypeJSON(
        _ accessToken: String
    ) -> [String: String] {
        return bearerAuthorization(accessToken) + contentTypeJSON
    }
    
    /// ```
    /// ["Content-Type": "application/x-www-form-urlencoded"]
    /// ```
    public static let formURLEncoded = [
        "Content-Type": "application/x-www-form-urlencoded"
    ]

    /**
     Makes the base64Encoded authorization header
     with the client id and secret.
     
     ```
     guard let encodedString = "\(clientId):\(clientSecret)"
             .base64Encoded()
     else {
         return nil
     }
     return ["Authorization": "Basic \(encodedString)"]
     ```
     
     - Parameters:
       - clientId: The client id.
       - clientSecret: The client secret.
     */
    public static func basicBase64Encoded(
        clientId: String, clientSecret: String
    ) -> [String: String]? {
        
        guard let encodedString = "\(clientId):\(clientSecret)"
                .base64Encoded()
        else {
            return nil
        }
        
        return ["Authorization": "Basic \(encodedString)"]
        
    }
    
    /// ```
    /// ["Content-Type": "image/jpeg"]
    /// ```
    public static let contentTypeImageJpeg = ["Content-Type": "image/jpeg"]
    
    
}
