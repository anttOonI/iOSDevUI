//
//  GroupCell.swift
//  VKClient
//
//  Created by AntonSobolev on 01.11.2020.
//

import UIKit

class AllGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configure(groupName: String?, groupAvatar: UIImage?) {
        self.groupName.text = groupName
        self.groupAvatar.image = groupAvatar
    }

}
