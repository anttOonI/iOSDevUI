//
//  Photo.swift
//  VKClient
//
//  Created by AntonSobolev on 13.02.2021.
//

import Foundation

class Photo: Codable {

    var id: Int = 0
    var ownerId: Int = 0
    var sizes: [Size] = []
    var likes: Like

    enum CodingKeys: String, CodingKey {
        case id
        case ownerId = "owner_id"
        case sizes
        case likes
    }

}

class Size: Codable {

    var url: String = ""
    var width: Int = 0
    var height: Int = 0
    var type: String = ""
}

class Like: Codable {

    var isLikedByUser: Int = 0
    var likesCount: Int = 0

    enum CodingKeys: String, CodingKey {
        case isLikedByUser = "user_likes"
        case likesCount = "count"
    }
}
