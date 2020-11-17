//
//  MyFriendsController.swift
//  VKClient
//
//  Created by AntonSobolev on 01.11.2020.
//

import UIKit

class MyFriendsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    //Словарь чтобы был ключ - Первая буква
    var myFriendsDict = [String: [Friend]]()
    var sectionTitles: [String] {myFriendsDict.keys.sorted()}
    
    var myFriends: [Friend] = [
        Friend(name: "Chendler Bing", avatar: "Chendler", imageCollection: ["Chendler", "Chendler1", "Chendler2"]),
        Friend(name: "Monica Geller", avatar: "Monica", imageCollection: ["Monica", "Monica1", "Monica2"]),
        Friend(name: "Joey Tribbiani", avatar: "Joey", imageCollection: ["Joey", "Joey1", "Joey2", "Joey3", "Joey4"]),
        Friend(name: "Rachell Green", avatar: "Rachell", imageCollection: ["Rachell", "Rachell1", "Rachell2"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        myFriendsDict = Dictionary(grouping: myFriends, by: {String($0.name.prefix(1))})
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let letterName = sectionTitles[section]
        if let friend = myFriendsDict[letterName] {
            return friend.count
        }
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myFriendCell", for: indexPath) as! MyFriendsTableViewCell
        let image = myFriends[indexPath.section].avatar
        let name = myFriends[indexPath.section].name
        
        cell.myFriendName.text = name
        // Присваивание свойству image у UIImageView картинку для аватарки и делаем ее круглой
        cell.myFriendAvatar.image = UIImage(named: image)
        cell.myFriendAvatar.layer.cornerRadius = cell.myFriendAvatar.frame.size.height / 2
        
        // Настройка UIView, который под картинкой,чтобы давал тень и был круглый
        cell.avatarView.layer.cornerRadius = cell.myFriendAvatar.frame.size.height / 2
        cell.avatarView.layer.shadowPath = UIBezierPath(roundedRect: cell.avatarView.bounds, cornerRadius: (cell.myFriendAvatar.frame.size.height / 2)).cgPath
        cell.avatarView.layer.shadowColor = UIColor.green.cgColor
        cell.avatarView.layer.shadowOffset = CGSize(width: 2, height: -1)
        cell.avatarView.layer.shadowOpacity = 0.8
        cell.avatarView.layer.shadowRadius = 5.0

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionTitles[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showCollection" else { return }
        guard let destination = segue.destination as? FriendsPhotosCollectionViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            if let friend = myFriendsDict[sectionTitles[indexPath.section]] {
                destination.photos = friend[indexPath.row].imageCollection

            }
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
