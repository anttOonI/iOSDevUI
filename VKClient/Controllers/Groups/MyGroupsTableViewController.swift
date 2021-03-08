//
//  MyGroupsController.swift
//  VKClient
//
//  Created by AntonSobolev on 01.11.2020.
//

import UIKit
import RealmSwift

class MyGroupsTableViewController: UITableViewController {
    
    private var myGroups: Results<Group>?
    private let downloadImage = DownloadImage()
    private var token: NotificationToken?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.realmNotifications()
    }
    
    // MARK: - Public Methods
    

    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            guard let allGroupsController = segue.source as? AllGroupsTableViewController else { return }
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                let selectedGroup = allGroupsController.groups[indexPath.row]
                GroupRequest.join(groupId: selectedGroup.id, completion: { [weak self] result in
                    guard result == 1 else {
                        return
                    }
//                    self?.updateGroups()
                })
            }
        }
    }
    
    private func realmNotifications() {
        
        guard let realm = try? Realm() else { return }
        self.myGroups = realm.objects(Group.self)
        self.token = myGroups?.observe({ [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial(_):
                self?.tableView.reloadData()
            case .update(_,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                self?.tableView.beginUpdates()
                
                self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                
                self?.tableView.endUpdates()
                
            case .error(let error):
                fatalError("Realm error \(error)")
            }
        })
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myGroupCell", for: indexPath) as! MyGroupTableViewCell
        
        guard let group = myGroups?[indexPath.row] else { return cell }
        downloadImage.getPhoto(byURL: group.avatarURL, completion: {  avatar in
            cell.configure(groupName: group.name, groupAvatar: avatar)
        })
        return cell
    }
    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            myGroups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
}
