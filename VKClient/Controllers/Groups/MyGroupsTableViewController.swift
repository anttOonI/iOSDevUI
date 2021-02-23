//
//  MyGroupsController.swift
//  VKClient
//
//  Created by AntonSobolev on 01.11.2020.
//

import UIKit

class MyGroupsTableViewController: UITableViewController {
    
    var myGroups = [Group]()
    private let downloadImage = DownloadImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateGroups()
    }
    
    // MARK: - Public Methods
    
    func updateGroups() {
        GroupRequest.get(completion: { [weak self] myGroups in
            self?.myGroups = myGroups
            self?.tableView.reloadData()
        })
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            guard let allGroupsController = segue.source as? AllGroupsTableViewController else { return }
            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                let selectedGroup = allGroupsController.groups[indexPath.row]
                GroupRequest.join(groupId: selectedGroup.id, completion: { [weak self] result in
                    guard result == 1 else {
                        return
                    }
                    self?.updateGroups()
                })
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myGroupCell", for: indexPath) as! MyGroupTableViewCell
        
        let group = myGroups[indexPath.row]
        downloadImage.getPhoto(byURL: group.avatarURL, completion: {  avatar in
            cell.configure(groupName: group.name, groupAvatar: avatar)
        })
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
