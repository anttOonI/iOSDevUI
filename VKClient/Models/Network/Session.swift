//
//  Session.swift
//  VKClient
//
//  Created by AntonSobolev on 19.12.2020.
//

import Foundation

final class Session {
    
    static var shared = Session()
    
    var userId: Int?
    var token: String?
    
    private init() {}
}
