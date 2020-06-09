//
//  Message.swift
//  TempMail
//
//  Created by Aravind Koneru on 6/2/20.
//  Copyright © 2020 Aravind Koneru. All rights reserved.
//

import Foundation

public struct InboxModel: Hashable, Codable, Identifiable {
    public let id: Int
    let from: String
    let subject: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case from = "from"
        case subject = "subject"
        case date = "date"
    }
}

public struct MessageModel: Hashable, Codable {
    let id: Int
    let from: String
    let subject: String
    let date: String
    let attachments: [AttachmentModel]?
    let body: String
    let textBody: String
    let htmlBody: String
}

public struct AttachmentModel: Hashable, Codable {
    let filename: String
    let contentType: String
    let size: Int
}
