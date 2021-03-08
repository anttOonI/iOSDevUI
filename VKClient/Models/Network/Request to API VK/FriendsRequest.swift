//
//  FriendsRequest.swift
//  VKClient
//
//  Created by AntonSobolev on 13.02.2021.
//

import Foundation
import RealmSwift

enum FriendFields: String {
    case nickname
    case domain
    case photo_50
    case photo_100
    case photo_200_orig
    case sex
    case bdate
    case city
    case country
    case timezone
    case has_mobile
    case contacts
    case education
    case online
    case relation
    case last_seen
    case status
    case can_write_private_message
    case can_see_all_posts
    case can_post
    case universities

}

/// Класс запросов к vk API для работы с друзьями
class FriendsRequest {

    private init() {}

    class func get(fields: [FriendFields] = [FriendFields.photo_100], completion: @escaping ([Friend]) -> Void) {

        let field = fields.lazy.map({ $0.rawValue }).joined(separator: ",")

        var urlConstructor = URLComponents()
        let session = URLSession.shared

        urlConstructor.scheme = RequestConstants.scheme
        urlConstructor.host = RequestConstants.host
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: ""),
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "fields", value: field),
            URLQueryItem(name: "count", value: ""),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: RequestConstants.versionAPI),
        ]

        guard let url = urlConstructor.url else { return }
        session.dataTask(with: url) { data, response, error in

            guard let data = data else { return }

            do {
                let friends = try JSONDecoder().decode(Response<Friend>.self, from: data).response.items
                DispatchQueue.main.async {
//                    saveData()
                    completion(friends)
                }
            } catch {
                print (error)
            }


        }.resume()
    }
    
    class func saveData() {
        FriendsRequest.get { friends in
            do {
                // получаем доступ к хранилищу
                let realm = try Realm()
                print(realm.configuration.fileURL)
                // получим старые объекты из базы
                let oldValues = realm.objects(Friend.self)
                // начинаем изменять хранилище
                realm.beginWrite()
                // удалим старые данные
                realm.delete(oldValues)
                // кладем все переданные в функцию объекты в хранилище
                realm.add(friends)
                // завершаем изменения хранилища
                try realm.commitWrite()
            } catch {
                // если произошла ошибка, выводим ее
                print(error)
            }
        }
    }

}
