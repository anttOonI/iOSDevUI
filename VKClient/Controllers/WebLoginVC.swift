//
//  WebLoginVC.swift
//  VKClient
//
//  Created by AntonSobolev on 21.12.2020.
//

import UIKit
import WebKit

class WebLoginVC: UIViewController {
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7706079"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webView.load(request)
        
        print(request)
    }
    
}

extension WebLoginVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        print("Вот мой токен \(params["access_token"])")
        print("Вот мой айди \(params["user_id"])")
        
        Session.shared.token = params["access_token"]
        Session.shared.userId = Int(params["user_id"]!)
        
        decisionHandler(.cancel)
        
        FriendsRequest.get(fields: [.photo_100, .city, .country] ,completion: { friends in
            print("Друзья: \n\(friends)")
        })
        
        GroupRequest.get(completion: {groups in
            print("Группы: \n\(groups)")
        })
        
        GroupRequest.search(group: "Swift", completion: { searchedGroups in
            print("Поиск по группам: \n\(searchedGroups)")

        })
        
        PhotoRequest.getAll(for: Session.shared.userId ?? 0, completion: { photos in
            print("Фото: \n\(photos)")

        })
        
        performSegue(withIdentifier: "showTabBar", sender: self)
    }
    
}
