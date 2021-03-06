import Foundation
import XCTest
import SpotifyWebAPI
import SpotifyAPITestUtilities
import SpotifyExampleContent

final class CodingPlaybackRequestTests: XCTestCase {
    
    static var allTests = [
        ("testCodingPlaybackReqest", testCodingPlaybackReqest)
    ]

    func testCodingPlaybackReqest() throws {
        
        do {
            let playbackRequest = PlaybackRequest(
                context: .contextURI(URIs.Albums.jinx),
                offset: .position(3),  // "fall down"
                positionMS: 50_000  // 50 seconds
            )
        
            encodeDecode(playbackRequest)
        }
        do {
            let playbackRequest = PlaybackRequest(
                context: .uris([
                    URIs.Tracks.faces,
                    URIs.Tracks.illWind,
                    URIs.Tracks.fearless
                ]),
                offset: .uri(URIs.Tracks.fearless),
                positionMS: 50_000  // 50 seconds
            )
            
            encodeDecode(playbackRequest)
        }
            
        do {
            let playbackRequest = PlaybackRequest(
                context: .contextURI(URIs.Playlists.crumb),
                offset: .position(10),
                positionMS: 100_000  // 100 seconds
            )
        
            encodeDecode(playbackRequest)
        }
        do {
            let playbackRequest = PlaybackRequest(
                context: .contextURI(URIs.Playlists.crumb),
                offset: .uri(URIs.Tracks.locket),
                positionMS: 100_000  // 100 seconds
            )
        
            encodeDecode(playbackRequest)
        }
        
        
    }
    
    
}
