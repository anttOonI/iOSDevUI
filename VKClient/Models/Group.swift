//
//  Group.swift
//  VKClient
//
//  Created by AntonSobolev on 29.12.2020.
//

import Foundation

class Group: Codable {

    var id: Int = 0
    var name: String = ""
    var avatarURL: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "photo_50"
    }


}
