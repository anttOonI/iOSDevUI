//
//  Friend.swift
//  VKClient
//
//  Created by AntonSobolev on 28.12.2020.
//
import Foundation

class Friend: Codable {

    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var avatarURL: String = ""
    var city: City?
    var country: Country?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_100"
        case city
        case country
    }

}

class City: Codable {
    var title: String = ""
}

class Country: Codable {
    var title: String = ""
}
