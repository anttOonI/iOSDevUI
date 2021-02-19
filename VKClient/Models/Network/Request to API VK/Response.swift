//
//  Response.swift
//  VKClient
//
//  Created by AntonSobolev on 13.02.2021.
//

import Foundation

class Response<T>: Codable where T: Codable {
    let response: Items<T>
}


class Items<T: Codable>: Codable {
    let items: [T]
}
