//
//  DownloadImage.swift
//  VKClient
//
//  Created by AntonSobolev on 14.02.2021.
//

import UIKit

class DownloadImage {

    func getPhoto(byURL url: String, completion: @escaping (UIImage) -> Void) {

        var image: UIImage?

        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

            guard let data = data else { return }
            image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image!)
            }

        }).resume()


    }
}
