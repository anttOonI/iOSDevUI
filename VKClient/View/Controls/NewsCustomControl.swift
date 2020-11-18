//
//  NewsCustomControl.swift
//  VKClient
//
//  Created by AntonSobolev on 16.11.2020.
//

import UIKit

class NewsCustomControl: FriendsLikesControl {
    
    //MARK: - Private properties
    
//    private var likeButton = UIButton()
//    private var likeCounterLabel = UILabel()
//    private var likeCounter = 0
//    private var didLike = false
    
    private var commentButton = UIButton()
    private var shareButton = UIButton()
    
    private var viewsIndicator = UIImageView()
    private var viewsCounterLabel = UILabel()
    private var viewsCounter = 0

    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
  
    // MARK: - Public Methods
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setupLabel() {
        NSLayoutConstraint.activate([
            
            likeCounterLabel.leadingAnchor.constraint(lessThanOrEqualTo: likeButton.trailingAnchor, constant: 5),
            likeCounterLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            likeCounterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }

    func setupCommentButton() {
        
    }
}
