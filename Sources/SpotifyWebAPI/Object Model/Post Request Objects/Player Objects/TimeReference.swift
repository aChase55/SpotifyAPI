import Foundation


/// Represents a period before or after a specified date.
/// Dates are converted to millisecond-precision timestamps.
///
/// Used in the body of `recentlyPlayed(_:limit:)`.
public enum TimeReference: Codable, Hashable {
    
    /// A period before a specified date.
    /// It will be converted to a millisecond-precision timestamp.
    case before(Date)
    
    /// A period after a specified date.
    /// It will be converted to a millisecond-precision timestamp.
    case after(Date)
    
    /**
     Returns self as a query item.
     
     The name will be "before" or "after" and the
     value will be the date in milliseconds since the unix
     epoch rounded to the nearest whole number.
     */
    public func asQueryItem() -> [String: String] {
        let name: String
        let date: Date
        switch self {
            case .before(let beforeDate):
                name = "before"
                date = beforeDate
            case .after(let afterDate):
                name = "after"
                date = afterDate
        }
        let milliseconds = String(format: "%.0f", date.millisecondsSince1970)
        return [name: milliseconds]
    }
    
    /// :nodoc:
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let beforeDate = try container.decodeMillisecondsSince1970IfPresent(
            forKey: .before
        ) {
            self = .before(beforeDate)
        }
        else if let beforeDate = try container.decodeMillisecondsSince1970IfPresent(
            forKey: .after
        ) {
            self = .after(beforeDate)
        }
        else {
            
            let errorMessage = "expected to find key 'before' or 'after' " +
                "with unix milliseconds (Double) as value"
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: errorMessage
                )
            )
            
        }
        
    }
    
    /// :nodoc:
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
            case .before(let beforeDate):
                try container.encodeMillisecondsSince1970(
                    beforeDate, forKey: .before
                )
            case .after(let afterDate):
                try container.encodeMillisecondsSince1970(
                    afterDate, forKey: .after
                )
        }
        
    }
    
    /// :nodoc:
    public enum CodingKeys: String, CodingKey {
        case before, after
    }
}
