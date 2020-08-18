import Foundation

public extension DateFormatter {
    
    /// "YYYY-MM-DD" Date format.
    static let spotifyAlbumLong: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        return formatter
    }()
    
    /// "YYYY-MM" Date format.
    static let spotifyAlbumMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM"
        return formatter
    }()
    
    /// "YYYY" Date format.
    static let spotifyAlbumShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return formatter
    }()
    
    /**
     A formatter for [timestamps][1] used by the Spotify web API.
     
     Timestamps are  in ISO 8601 format as Coordinated Universal Time (UTC)
     with a zero offset:
     ```
     "YYYY-MM-DD'T'HH:mm:SSZ"
     ```

     [1]: https://developer.spotify.com/documentation/web-api/#timestamps
     */
    static let spotifyTimeStamp: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:SSZ"
        return formatter
    }()
    
    
    /// Used for debugging purposes.
    ///
    /// ```
    /// "hh-mm-ss"
    /// ```
    static let shortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh-mm-ss"
        return formatter
    }()
    
}

public extension KeyedDecodingContainer {
    
    
    /**
     Decodes a Date from a date-string with one of
     the following formats:
    
     - "YYYY-MM-DD"
     - "YYYY-MM"
     - "YYYY"
    
     - Parameter key: The key that is associated with a date string
           in one of the above formats.
     - Throws: If the value cannot be decded into a string,
           or if the format of the string does not match
           any of the above formats.
     - Returns: The decoded Date.
     */
    func decodeSpotifyAlbumDate(forKey key: Key) throws -> Date {
        
        let dateString = try self.decode(String.self, forKey: key)
        
        if let longDate = DateFormatter.spotifyAlbumLong
                .date(from: dateString) {
            return longDate
        }
        else if let mediumDate = DateFormatter.spotifyAlbumMedium
                .date(from: dateString) {
            return mediumDate
        }
        else if let shortDate = DateFormatter.spotifyAlbumShort
                .date(from: dateString) {
            return shortDate
        }
        else {
            
            let errorMessage = """
                Could not decode Spotify album date: '\(dateString)'.
                It must be in one of the following formats:
                "YYYY-MM-DD"
                "YYYY-MM"
                "YYYY"
                """
            
            throw DecodingError.typeMismatch(
                Date.self,
                DecodingError.Context(
                    codingPath: self.codingPath,
                    debugDescription: errorMessage
                )
            )
        }
    }
    
    
}


public extension KeyedEncodingContainer {
    
    mutating func _encode(
        _ value: String,
        forKey key: KeyedEncodingContainer<K>.Key
    ) throws {
        
        fatalError("not implemented")
    }
    
    /**
     Encodes a Sate to a date-string in one of
     the following formats, depending on the `datePrecision`.
     
     The expected values for `datePrecision` are:
     
     - "YYYY-MM-DD" if `datePrecision` == "day"
     - "YYYY-MM" if `datePrecision` == "month"
     - "YYYY" if `datePrecision` == "year" or == `nil`.
     
     - Parameters:
       - date: A Date.
       - datePrecision: One of the above-mentioned values.
       - key: A key to associate the Date with.
     - Throws: If the date string could not be encoded
           into the container for the given key.
     */
    mutating func encodeSpotifyAlbumDate(
        _ date: Date,
        datePrecision: String?,
        forKey key: Key
    ) throws {
        
        let formatter: DateFormatter
        
        switch datePrecision {
            case "day":
                formatter = .spotifyAlbumLong
            case "month":
                formatter = .spotifyAlbumMedium
            default:
                formatter = .spotifyAlbumShort
        }
        
        let dateString = formatter.string(from: date)
        
        try self.encode(dateString, forKey: key)
        
    }
    
    
}
