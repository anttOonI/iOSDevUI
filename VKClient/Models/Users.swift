//
//  Users.swift
//  VKClient
//
//  Created by AntonSobolev on 28.12.2020.
//"items": [{

import Foundation

struct UserResponse: Decodable {
    
    let response: Response
    
    class User: Decodable {
        
        var id = 0
        var firstName = ""
        var lastName = ""
        var image = ""
        
        enum ItemsKeys: String, CodingKey {
            case id
            case firstName = "first_Name"
            case lastName = "last_Name"
            case image = "photo_50"

        }

    }

    struct Response {
        let items = [User]
    }
    
}


