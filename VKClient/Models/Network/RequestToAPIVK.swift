//
//  RequestToAPIVK.swift
//  VKClient
//
//  Created by AntonSobolev on 23.12.2020.
//

import Foundation
import Alamofire


public extension Dictionary {
    /// Merges the dictionary with dictionaries passed. The latter dictionaries will override
    /// values of the keys that are already set
    ///
    /// - parameter dictionaries: A comma seperated list of dictionaries
    mutating func merge<K, V>(dictionaries: Dictionary<K, V>...) {
        for dict in dictionaries {
            for (key, value) in dict {
                self.updateValue(value as! Value, forKey: key as! Key)
            }
        }
    }
}

class RequestToAPIVK {
    
    let baseUrl = "https://api.vk.com/method/"
    private var parameters: Parameters = [
        "access_token": Session.shared.token!,
        "v": 5.126
    ]
        
    func getFriends() {
        
        let methodName = "friends.get"
        let url = baseUrl + methodName
        
        AF.request(url, parameters: parameters).responseJSON { response in
            print("Список друзей \(response.value)")
        }
    }
    func getPhotos() {
        
        let methodName = "photos.get"
        let url = baseUrl + methodName
        
        var parametersApi: Parameters = [
            "owner_id": Session.shared.userId!,
            "album_id": "profile"
        ]
        
        parametersApi.merge(dictionaries: parameters)
        
        AF.request(url, parameters: parametersApi).responseJSON { response in
            print("Фотографии \(response.value)")
        }
    }
    
    func getGroups() {
        
        let methodName = "groups.get"
        let url = baseUrl + methodName
        
        var parametersApi: Parameters = [
            "user_id": Session.shared.userId!,
            "count": 5
        ]
        
        parametersApi.merge(dictionaries: parameters)
        
        AF.request(url, parameters: parametersApi).responseJSON { response in
            print("Группы \(response.value)")
        }
    }
    
    func getSearchingGroups(searhingFor: String) {
        
        let searchingGroup = searhingFor
        let methodName = "groups.search"
        let url = baseUrl + methodName
        
        var parametersApi: Parameters = [
            "q": searchingGroup,
            "type": "group",
            "count": 5
        ]
        
        parametersApi.merge(dictionaries: parameters)
        
        AF.request(url, parameters: parametersApi).responseJSON { response in
            print("По поиску \(searchingGroup) нашлось: \(response.value)")
        }
    }
    
    

}
