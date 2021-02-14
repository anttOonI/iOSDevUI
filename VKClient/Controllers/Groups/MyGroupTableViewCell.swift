//
//  MyGroupCell.swift
//  VKClient
//
//  Created by AntonSobolev on 01.11.2020.
//

import UIKit

class MyGroupTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myGroupName: UILabel!
    @IBOutlet weak var myGroupImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(groupName: String?, groupAvatar: UIImage?) {
            self.myGroupName.text = groupName
            self.myGroupImage.image = groupAvatar
        }
}
