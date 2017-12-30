//
//  Message.swift
//  SlackHook
//
//  Created by Graeme Read on 30/12/2017.
//

import Foundation

public struct Message: Codable {
    let text: String
    let username: String?
    
    public init(text: String, username: String? = nil) {
        self.text = text
        self.username = username
    }
}
