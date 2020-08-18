import Foundation

/// The data from the Spotify web API could not be decoded
/// into any of the expected types.
///
/// This is almost always due to an error in this library.
/// Report a bug if you get this error.
public struct SpotifyDecodingError: LocalizedError, CustomStringConvertible {
    
    public static var fileURL: URL {
        let dateString = DateFormatter.shortTime.string(from: Date())
        return URL(fileURLWithPath:
            "/Users/pschorn/Desktop/response_\(dateString).json"
        )
    }
    
    /// The raw data returned by the server.
    /// You should almost always be able to decode
    /// this into a string.
    public let rawData: Data?
    
    /// The `rawData` decoded into a string or nil
    /// if it couldn't be decoded.
    public var dataString: String?
    
    /// The expected response object.
    public let expectedResponseObject: Any.Type
    
    /// The http status code.
    public let statusCode: Int?
    
    /// Usually one of the JSON decoding error types.
    public let underlyingError: Error?
    
    public init (
        rawData: Data?,
        responseObject: Any.Type,
        statusCode: Int?,
        underlyingError: Error?
    ) {
        self.rawData = rawData
        
        self.dataString = rawData.map {
            String(data: $0, encoding: .utf8)
        } as? String
        
        self.expectedResponseObject = responseObject
        self.statusCode = statusCode
        self.underlyingError = underlyingError
        
        if let data = rawData,
                var dataString = String(data: data, encoding: .utf8) {
            dataString = "\n\n\n" + dataString
            try! dataString.write(
                to: Self.fileURL, atomically: true, encoding: .utf8
            )
        }
    }
    
    public var description: String {
        
        let dataString = self.dataString
                ?? "The data could not be decoded into a string"
        
        var underlyingErrorString = ""
        if let error = underlyingError {
            dump(error, to: &underlyingErrorString)
        }
        else {
            underlyingErrorString = "nil"
        }

        let statusCodeString = statusCode.map(String.init) ?? "nil"
        
        var codingPath = ""
        if let path = (underlyingError as? DecodingError)?
                .prettyCodingPath {
            codingPath = "\nformatted coding path: \(path)"
        }
        
        return """
            SpotifyDecodingError: The data from the Spotify web API \
            could not be decoded into '\(expectedResponseObject)'
            http status code: \(statusCodeString)\(codingPath)
            Underlying error:
            \(underlyingErrorString)
            raw data:
            \(dataString)
            """
    }

}
