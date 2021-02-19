//
//  AllGroupsController.swift
//  VKClient
//
//  Created by AntonSobolev on 01.11.2020.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {
    
    //    var allGroups: [Group] = [
    //        Group(groupName: "CentralPerkCafe", image: "CentralPerk"),
    //        Group(groupName: "MonicaHouse", image: "Apartment")
    //    ]
    private let downloadImage = DownloadImage()
    var groups = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableGroupTableCell", for: indexPath) as! AllGroupTableViewCell
        
        let group = groups[indexPath.row]
        
        downloadImage.getPhoto(byURL: group.avatarURL, completion: { avatar in
            cell.configure(groupName: group.name, groupAvatar: avatar)
        })
    
        return cell
    }
    
    
}
