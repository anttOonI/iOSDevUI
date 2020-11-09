//
//  LikeControl.swift
//  VKClient
//
//  Created by AntonSobolev on 09.11.2020.
//

import UIKit

class LikeControl: UIControl {
    
    private var likeButton = UIButton()
    private var likeCounterLabel = UILabel()
    private var likeCounter = 0
    private var didLike = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
        self.setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupButton()
        self.setupLabel()
    }
    
    
    private func setupButton() {
        
        addSubview(likeButton)
        
        likeButton.setImage(UIImage(named: "Thumbs50")?.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.tintColor = UIColor.white
        likeButton.addTarget(self, action: #selector(tapLikeControl), for: .touchUpInside)
        
    }
    
    private func setupLabel() {
        
        addSubview(likeCounterLabel)
        
        likeCounterLabel.textColor = .red
        likeCounterLabel.textAlignment = .right
        likeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка AutoLayout
        NSLayoutConstraint.activate([
            
            likeCounterLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 5),
            likeCounterLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor)
        ])
        
        updateCountOfLikesLabel()
    }
    
    private func updateCountOfLikesLabel() {
        
        switch likeCounter {
        case 0...999:
            likeCounterLabel.text = String(likeCounter)
        case 1000...1_000_000:
            likeCounterLabel.text = String(likeCounter / 1000) + "k"
        default:
            likeCounterLabel.text = "x"
        }
        
//        likeCounterLabel.textColor = didLike ? UIColor.red : UIColor.white
    }
    
    
    @objc func tapLikeControl() {
        
        didLike = !didLike
        
        if didLike {
            likeButton.tintColor = UIColor.red
            likeCounter += 1
            updateCountOfLikesLabel()
        } else {
            likeButton.tintColor = UIColor.white
            likeCounter -= 1
            updateCountOfLikesLabel()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        likeButton.frame = CGRect(x: 1, y: 0, width: 25, height: 25)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
