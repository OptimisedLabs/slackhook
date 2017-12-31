//
//  Attachment.swift
//  SlackHook
//
//  Created by Graeme Read on 31/12/2017.
//

import Foundation

public struct Attachment: Codable {
    let colour: Colour?
    let text: String?
    let title: String?
    let markdown: [MarkDownUsedIn]?
    
    public enum Colour: String, Codable {
        case good
        case warning
        case danger
    }
    
    public enum MarkDownUsedIn: String, Codable {
        case text
        case fields
    }
}

extension Attachment {
    enum CodingKeys: String, CodingKey {
        case colour = "color"
        case text
        case title
        case markdown = "mrkdwn_in"
    }
}
