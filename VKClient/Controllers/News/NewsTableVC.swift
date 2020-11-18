//
//  NewsTableVC.swift
//  VKClient
//
//  Created by AntonSobolev on 18.11.2020.
//

import UIKit

class NewsTableVC: UITableViewController {

    private var news: [News] = [
        News(author: "Joey Tribbiani", newsImage: "JoeyHB", newsText: "Господи, за что?! Мы же договорились! Пусть другие стареют, а не я!"),
        News(author: "Chendler Bing", newsImage: "ChendlerThoughts", newsText: "Странная вещь: Дональд Дак не надевал штанов, но, выходя из душа, обвязывался полотенцем... Спрашивается, почему?")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        let friendNews = news[indexPath.row]
        
        cell.author.text = friendNews.author
        cell.newsText.text = friendNews.newsText
        cell.newsImage.image = UIImage(named: friendNews.newsImage)
        //cell.myFriendAvatar.image = UIImage(named: friend[indexPath.row].avatar)
        
        return cell
    }

}
