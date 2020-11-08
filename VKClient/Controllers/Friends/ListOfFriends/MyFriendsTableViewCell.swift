//
//  MyFriendsCell.swift
//  VKClient
//
//  Created by AntonSobolev on 01.11.2020.
//

import UIKit

class MyFriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var myFriendName: UILabel!
    @IBOutlet weak var myFriendAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
