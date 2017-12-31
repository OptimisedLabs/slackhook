//
//  Message.swift
//  SlackHook
//
//  Created by Graeme Read on 30/12/2017.
//

import Foundation

public struct Message: Codable {
    var text: String?
    var username: String?
    var attachments: [Attachment]?
}

extension Message {
    public init(text: String) {
        self.text = text
        self.username = nil
        self.attachments = nil
    }
    
    public init(attachments: [Attachment]) {
        self.text = nil
        self.username = nil
        self.attachments = attachments
    }
}
