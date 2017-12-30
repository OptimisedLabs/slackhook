//
//  SlackError.swift
//  SlackHook
//
//  Created by Graeme Read on 30/12/2017.
//

import Foundation

public enum SlackError: Error {
    /// HTTPS should always be used as a webhook
    case webhookNotSecure
}
