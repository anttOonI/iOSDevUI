//
//  RequestToAPIVK.swift
//  VKClient
//
//  Created by AntonSobolev on 23.12.2020.
//

import Foundation

//deprecated
//import Alamofire
//
//
//public extension Dictionary {
//    /// Merges the dictionary with dictionaries passed. The latter dictionaries will override
//    /// values of the keys that are already set
//    ///
//    /// - parameter dictionaries: A comma seperated list of dictionaries
//    mutating func merge<K, V>(dictionaries: Dictionary<K, V>...) {
//        for dict in dictionaries {
//            for (key, value) in dict {
//                self.updateValue(value as! Value, forKey: key as! Key)
//            }
//        }
//    }
//}
//
//class RequestToAPIVK {
//
//    let baseUrl = "https://api.vk.com/method/"
//    private var version = 5.126
//
//
//    func getFriends() {
//
//        let methodName = "friends.get"
//        let url = baseUrl + methodName
//
//        let parameters: Parameters = [
//            "access_token": Session.shared.token!,
//            "v": version,
//            "count": 3,
//            "offset": "5",
//            "fields": "domain,has_mobile,photo_50"
//        ]
//
//        AF.request(url, parameters: parameters).responseJSON { response in
//            print("Список друзей \(response.value)")
//        }
//    }
//    func getPhotos() {
//
//        let methodName = "photos.get"
//        let url = baseUrl + methodName
//
//        let parameters: Parameters = [
//            "access_token": Session.shared.token!,
//            "v": version,
//            "owner_id": Session.shared.userId!,
//            "album_id": "profile"
//        ]
//
//        AF.request(url, parameters: parameters).responseJSON { response in
//            print("Фотографии \(response.value)")
//        }
//    }
//
//    func getGroups() {
//
//        let methodName = "groups.get"
//        let url = baseUrl + methodName
//
//        let parameters: Parameters = [
//            "access_token": Session.shared.token!,
//            "v": version,
//            "user_id": Session.shared.userId!,
//            "count": 5
//        ]
//
//        AF.request(url, parameters: parameters).responseJSON { response in
//            print("Группы \(response.value)")
//        }
//    }
//
//    func getSearchingGroups(searhingFor: String) {
//
//        let searchingGroup = searhingFor
//        let methodName = "groups.search"
//        let url = baseUrl + methodName
//
//        var parameters: Parameters = [
//            "access_token": Session.shared.token!,
//            "v": version,
//            "q": searchingGroup,
//            "type": "group",
//            "count": 5
//        ]
//
//        AF.request(url, parameters: parameters).responseJSON { response in
//            print("По поиску \(searchingGroup) нашлось: \(response.value)")
//        }
//    }
//
//
//
//}
