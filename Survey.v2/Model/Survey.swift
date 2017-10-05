//
//  Survey.swift
//  Survey.v2
//
//  Created by Kaden Oldham on 10/5/17.
//  Copyright © 2017 Kaden Oldham. All rights reserved.
//

import Foundation

struct Survey {
    
    //MARK: - keys
    private let nameKey = "name"
    private let emojiKey = "emoji"
    private let uuidKey = "uuid"
    
    
    //MARK: - Properties
    let name: String
    let emoji: String
    let identifier: UUID // - like a time stamp right then and there.
    
    //MARK: - MemberWise init
    init(name: String, emoji: String, identifier: UUID = UUID() ) {
        self.name = name
        self.emoji = emoji
        self.identifier = identifier
    }
    
    //MARK: - Failable
    init?(dictionary: [String: String], identifier: String) {
        guard let name = dictionary[nameKey],
        let emoji = dictionary[emojiKey],
        let identifier = UUID(uuidString: identifier) else { return(nil) }
    
        
        self.name = name
        self.emoji = emoji
        self.identifier = identifier
    }
    //MARK: - Dictionary Rep
    var dictionaryRep: [String: Any] {
        let dictionary: [String: Any] = [
            nameKey: name,
            emojiKey: emoji,
            uuidKey: identifier.uuidString]
        return dictionary
    }

    
    
    // Turn on serialize dictionaryRep into Data
    // return JSON data from out object
    //MARK: - PUT to JSON
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: dictionaryRep, options: .prettyPrinted)
    }
}


























