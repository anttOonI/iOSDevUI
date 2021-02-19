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
    
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        return recognizer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarView.isUserInteractionEnabled = true
        avatarView.addGestureRecognizer(tapGestureRecognizer)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(friendName: String, friendAvatar: UIImage?) {

            self.myFriendName.text = friendName
            self.myFriendAvatar.image = friendAvatar
        }
    
    
    @objc func onTap() {
        //        UIView.animate(withDuration: 0.5, animations: { self.image.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)})
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.9,
                       options: [],
                       animations: {
                        let scale = CGAffineTransform(scaleX: 0.9, y: 0.9)
                        self.avatarView.transform = scale
                       },
                       completion: { _ in
                        let scale = CGAffineTransform(scaleX: 1, y: 1)
                        self.avatarView.transform = scale
                       })
    }
    
}
