//
//  PhotoRequest.swift
//  VKClient
//
//  Created by AntonSobolev on 14.02.2021.
//

import Foundation
import RealmSwift

class PhotoRequest {

    private init() {}

    class func getAll(for ownerId: Int?, completion: @escaping ([Photo]) -> Void) {

        guard let ownerId = ownerId else { return }
        var urlConstructor = URLComponents()
        let session = URLSession.shared

        urlConstructor.scheme = RequestConstants.scheme
        urlConstructor.host = RequestConstants.host
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: String(ownerId)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: RequestConstants.versionAPI)
        ]

        guard let url = urlConstructor.url else { return }
        session.dataTask(with: url) { (data, response, error) in

            guard let data = data else { return }
            do {
                let photos = try JSONDecoder().decode(Response<Photo>.self, from: data).response.items
                DispatchQueue.main.async {
                    saveData(userID: ownerId)
                    completion(photos)
                }
            } catch  {
                print(error)
            }

        }.resume()
    }

    class func saveData(userID: Int?) {
        
        PhotoRequest.getAll(for: userID) { photos in
            do {
                // получаем доступ к хранилищу
                let realm = try Realm()
                // получим старые объекты из базы
                let oldValues = realm.objects(Photo.self).filter("ownerId == %@", userID ?? -1)
                // начинаем изменять хранилище
                realm.beginWrite()
                // удалим старые данные
                realm.delete(oldValues)
                // кладем все переданные в функцию объекты в хранилище
                realm.add(photos)
                // завершаем изменения хранилища
                try realm.commitWrite()
            } catch {
                // если произошла ошибка, выводим ее
                print(error)
            }
        }
    }
}
