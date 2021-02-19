//
//  Group.swift
//  VKClient
//
//  Created by AntonSobolev on 29.12.2020.
//

import Foundation
import RealmSwift

class Group: Object, Codable {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var avatarURL: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatarURL = "photo_50"
    }


}
