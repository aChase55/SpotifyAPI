import Foundation

/**
 Indicates where in the context playback should start.
 See `PlaybackRequest`.
 
 One of the following:
 
 * `position(Int)`: The index of the item in the context at which to
   start playback. Cannot be used if the context is an artist.
 * `uri(SpotifyURIConvertible)`: The URI of the item in the context
   to start playback at.
*/
public enum OffsetOption {
    
    /// The index of the item in the context at which to
    /// start playback. Cannot be used if the context is an artist.
    case position(Int)
    
    /// The URI of the item in the context to start playback at.
    case uri(SpotifyURIConvertible)
}

extension OffsetOption: Codable {
    
    /// :nodoc:
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let positionDictionary = try? container.decodeIfPresent(
            [String: Int].self,
            forKey: .offset
        ) {
            guard let position = positionDictionary["position"] else {
                let debugDescription = """
                    exptected to find key "position" in the following \
                    dictionary:
                    \(positionDictionary)
                    """
                throw DecodingError.dataCorruptedError(
                    forKey: .offset,
                    in: container,
                    debugDescription: debugDescription
                )
            }
            self = .position(position)
        }
        else if let uriOffsetDictionary = try? container.decodeIfPresent(
            [String: String].self,
            forKey: .offset
        ) {
            guard let uriOffset = uriOffsetDictionary["uri"] else {
                let debugDescription = """
                    expected to find key "uri" in the following \
                    dictionary:
                    \(uriOffsetDictionary)
                    """
                throw DecodingError.dataCorruptedError(
                    forKey: .offset,
                    in: container,
                    debugDescription: debugDescription
                )
            }
            self = .uri(uriOffset)
        }
        else {
            let debugDescription = """
                expected to find one of the following for key "offset":
                1) dictionary with single key "position" and int value
                2) dictionary with single key "uri" and string value
                """
            throw DecodingError.dataCorruptedError(
                forKey: .offset,
                in: container,
                debugDescription: debugDescription
            )
        }
        
    }
    
    /// :nodoc:
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
            case .position(let index):
                try container.encode(
                    ["position": index],
                    forKey: .offset
                )
            case .uri(let uri):
                try container.encode(
                    ["uri": uri.uri],
                    forKey: .offset
                )
        }
        
    }
    
    /// :nodoc:
    public enum CodingKeys: String, CodingKey {
        case offset
    }

}

extension OffsetOption: Hashable {
    
    /// :nodoc:
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case (.position(let lhsIndex), .position(let rhsIndex)):
                return lhsIndex == rhsIndex
            case (.uri(let lhsURI), .uri(let rhsURI)):
                return lhsURI.uri == rhsURI.uri
            default:
                return false
        }
    }
    
    /// :nodoc:
    public func hash(into hasher: inout Hasher) {
        switch self {
            case .position(let index):
                hasher.combine(index)
            case .uri(let uri):
                hasher.combine(uri.uri)
        }
    }
    
}
