//
//  MyFriendsController.swift
//  VKClient
//
//  Created by AntonSobolev on 01.11.2020.
//

import UIKit
import RealmSwift

class MyFriendsTableVC: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!

    private var myFriends: Results<Friend>?
    
    private var myFriendsDict = [String: [Friend]]()
    private var sectionTitles: [String] { myFriendsDict.keys.sorted() }
    private var startingFriendsDict = [String: [Friend]]()
    
    private let downloadImage = DownloadImage()
    
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        FriendsRequest.get(completion: { [weak self] friends in
//            self?.loadData()
//            self?.myFriendsDict = Dictionary(grouping: friends, by: { String($0.firstName.prefix(1)) })
//            self?.startingFriendsDict = self?.myFriendsDict ?? [:]
//            self?.tableView.reloadData()
//        })
        
        self.realmNotifications()
        FriendsRequest.saveData()
        
        startingFriendsDict = myFriendsDict
        searchBar.delegate = self
        
    }
    
    private func realmNotifications() {
        
        guard let realm = try? Realm() else { return }
        self.myFriends = realm.objects(Friend.self)
        self.token = myFriends?.observe({ [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial,.update:
                self?.myFriendsDict = Dictionary(grouping: (self?.myFriends)!, by: { String($0.firstName.prefix(1)) })
                self?.startingFriendsDict = self?.myFriendsDict ?? [:]
                self?.tableView.reloadData()
            case .error(let error):
                fatalError("Realm error \(error)")
            }
        })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letterName = sectionTitles[section]
        if let friend = myFriendsDict[letterName] {
            return friend.count
        }
        
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myFriendCell", for: indexPath) as! MyFriendsTableViewCell
        
        let letter = sectionTitles[indexPath.section]
        
        /*
         if let friend = friendDictionary[letter] {
               imageService.getPhoto(byURL: friend[indexPath.row].avatarURL, completion: { avatar in
                   let fullName = friend[indexPath.row].firstName + " " + friend[indexPath.row].lastName

                   cell.configure(friendName: fullName, friendAvatar: avatar)
               })
         */
        if let friend = myFriendsDict[letter] {
//            cell.myFriendName.text = friend[indexPath.row].name
//            cell.myFriendAvatar.image = UIImage(named: friend[indexPath.row].avatar)
            downloadImage.getPhoto(byURL: friend[indexPath.row].avatarURL, completion: { avatar in
                
                let fullName = friend[indexPath.row].firstName + " " + friend[indexPath.row].lastName

                cell.configure(friendName: fullName, friendAvatar: avatar)
            })
        }
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
        guard let destination = segue.destination as? FriendsPhotosCollectionVC else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            if let friend = myFriendsDict[sectionTitles[indexPath.section]] {
                destination.friendId = friend[indexPath.row].id
                
            }
        }
    }
}

extension MyFriendsTableVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        myFriendsDict = searchText.isEmpty ? startingFriendsDict : startingFriendsDict.mapValues({
            $0.filter({
                $0.firstName.lowercased().contains(searchText.lowercased())
            })
        }).filter({
            !$0.value.isEmpty
        })
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        myFriendsDict = startingFriendsDict
        tableView.reloadData()
        
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
