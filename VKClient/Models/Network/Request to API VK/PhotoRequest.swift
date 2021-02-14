//
//  PhotoRequest.swift
//  VKClient
//
//  Created by AntonSobolev on 14.02.2021.
//

import Foundation

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
                    completion(photos)
                }
            } catch  {
                print(error)
            }

        }.resume()
    }

}
