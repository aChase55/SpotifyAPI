import Foundation

/**
 The various actions that can be performed within the context
 of the user's current playback.
 
 For example, you cannot skip to the previous or next track/episode
 or seek to a position in a track/episode while an ad is playing.
 
 This enum maps to Spotify's [dissallows object][1].
 
 [1]: https://developer.spotify.com/documentation/web-api/reference/object-model/#disallows-object
 */
public enum PlaybackActions: String, Codable, Hashable, CaseIterable {
    
    /// Interrupt playback.
    case interruptPlayback = "interrupting_playback"
    
    /// Pausing.
    case pause = "pausing"
    
    /// Resuming.
    case resume = "resuming"
    
    /// Seeking.
    case seek = "seeking"
    
    /// Skipping to next.
    case skipToNext = "skipping_next"
    
    /// Skipping to previous.
    case skipToPrevious = "skipping_prev"
    
    /// Toggling the repeat context.
    case toggleRepeatContext = "toggling_repeat_context"
    
    /// Toggling repeat track.
    case toggleRepeatTrack = "toggling_repeat_track"
    
    /// Toggling shuffle.
    case toggleShuffle = "toggling_shuffle"
    
    /// Transferring playback.
    case transferPlayback = "transferring_playback"
    
    // The default implementation returns an array,
    // but a set is more useful.
    public static let allCases: Set<PlaybackActions> = [
        .interruptPlayback,
        .pause,
        .resume,
        .seek,
        .skipToNext,
        .skipToPrevious,
        .toggleRepeatContext,
        .toggleRepeatTrack,
        .toggleShuffle,
        .transferPlayback
    ]
    
}
