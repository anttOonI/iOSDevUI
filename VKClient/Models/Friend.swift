//
//  Friend.swift
//  VKClient
//
//  Created by AntonSobolev on 28.12.2020.
//
import Foundation
import RealmSwift

class Friend: Object, Codable {

    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatarURL: String = ""
    @objc dynamic var city: City?
    @objc dynamic var country: Country?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_100"
        case city
        case country
    }

}

class City: Object, Codable {
    @objc dynamic var title: String = ""
}

class Country: Object, Codable {
    @objc dynamic var title: String = ""
}
