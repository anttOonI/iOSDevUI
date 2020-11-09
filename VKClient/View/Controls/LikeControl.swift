//
//  LikeControl.swift
//  VKClient
//
//  Created by AntonSobolev on 09.11.2020.
//

import UIKit

class LikeControl: UIControl {

    private var likeButton: UIButton =  UIButton(type: .system)
    private var countOfLikes: UILabel
    
    private func setupView() {
        let buttonImage = UIImage(named: "LikeThumbs50")
        likeButton.setImage(buttonImage, for: .normal)
        likeButton.backgroundColor = UIColor.red
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
