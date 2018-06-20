import Foundation

public enum SlackError: Error {
    /// HTTPS should always be used as a webhook
    case webhookNotSecure
}
