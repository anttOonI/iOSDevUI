//
//  GroupRequest.swift
//  VKClient
//
//  Created by AntonSobolev on 13.02.2021.
//

import Foundation
import RealmSwift

enum GroupFields: String {
    case city
    case country
    case place
    case description
    case wiki_page
    case members_count
    case counters
    case start_date
    case finish_date
    case can_post
    case can_see_all_posts
    case activity
    case status
    case contacts
    case links
    case fixed_post
    case verified
    case site
    case can_create_topic
}

/// Класс запросов к vk API для работы с сообществами
class GroupRequest {

    private init() {}

    class func get(fields: [GroupFields] = [GroupFields.description], completion: @escaping ([Group]) -> Void) {

        let field = fields.lazy.map({ $0.rawValue }).joined(separator: ",")

        var urlConstructor = URLComponents()
        let session = URLSession.shared

        urlConstructor.scheme = RequestConstants.scheme
        urlConstructor.host = RequestConstants.host
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: field),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: RequestConstants.versionAPI),
        ]

        guard let url = urlConstructor.url else { return }
        session.dataTask(with: url) { data, _, error in

            guard let data = data else { return }

            do {
                let groups = try JSONDecoder().decode(Response<Group>.self, from: data).response.items
                DispatchQueue.main.async {
                    completion(groups)
                }
            } catch {
                print(error)
            }

        }.resume()
    }


 // completion: замыкание для возврата результата запроса. После успешного выполнения возвращает массив объектов Group.
    class func search(group name: String?, completion: @escaping ([Group]) -> Void) {

        var urlConstructor = URLComponents()
        let session = URLSession.shared

        urlConstructor.scheme = RequestConstants.scheme
        urlConstructor.host = RequestConstants.host
        urlConstructor.path = "/method/groups.search"
        urlConstructor.queryItems = [
            URLQueryItem(name: "q", value: name),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: RequestConstants.versionAPI),
        ]

        guard let url = urlConstructor.url else { return }
        session.dataTask(with: url) { data, _, error in

            guard let data = data else { return }

            do {
                let searchedGroups = try JSONDecoder().decode(Response<Group>.self, from: data).response.items
                DispatchQueue.main.async {
                    completion(searchedGroups)
                }
            } catch {
                print(error)
            }

        }.resume()
    }


   class func join(groupId: Int, completion: @escaping (Int) -> Void) {

        var UrlConstructor = URLComponents()
        let session = URLSession.shared

        UrlConstructor.scheme = RequestConstants.scheme
        UrlConstructor.host = RequestConstants.host
        UrlConstructor.path = "/method/groups.join"
        UrlConstructor.queryItems = [
            URLQueryItem(name: "group_id", value: String(groupId)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: RequestConstants.versionAPI)
        ]

        guard let url = UrlConstructor.url else { return }

        session.dataTask(with: url, completionHandler: { data, _, error in

            guard let data = data else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                let responseJson = json as! [String: Int]
                let response = responseJson["response"]!

                DispatchQueue.main.async {
                    completion(response)
                }
            } catch {
                print(error)
            }
        }).resume()

    }

    class func leave(groupId: Int, completion: @escaping (Int) -> Void) {

        var urlConstructor = URLComponents()

        urlConstructor.scheme = RequestConstants.scheme
        urlConstructor.host = RequestConstants.host
        urlConstructor.path = "/method/groups.leave"
        urlConstructor.queryItems = [
            URLQueryItem(name: "group_id", value: String(groupId)),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: RequestConstants.versionAPI)
        ]

        guard let url = urlConstructor.url else { return }

        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in

            guard let data = data else { return }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                let responseJson = json as! [String: Int]
                let response = responseJson["response"]!
                DispatchQueue.main.async {
                    saveData()
                    completion(response)
                }
            } catch {
                print(error)
            }

        }).resume()

    }

    class func saveData() {
        GroupRequest.get { groups in
            do {
                // получаем доступ к хранилищу
                let realm = try Realm()
                // получим старые объекты из базы
                let oldValues = realm.objects(Group.self)
                // начинаем изменять хранилище
                realm.beginWrite()
                // удалим старые данные
                realm.delete(oldValues)
                // кладем все переданные в функцию объекты в хранилище
                realm.add(groups)
                // завершаем изменения хранилища
                try realm.commitWrite()
            } catch {
                // если произошла ошибка, выводим ее
                print(error)
            }
        }
    }
    
}
