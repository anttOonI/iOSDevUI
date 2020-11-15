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
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
    }
    
    
    private func setupButton() {
        
        addSubview(likeButton)
        
        likeButton.setImage(UIImage(named: "Thumbs50")?.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.tintColor = UIColor.white
        //        likeButton.imageEdgeInsets = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1  )
        likeButton.addTarget(self, action: #selector(tapLikeControl), for: .touchUpInside)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        //        likeButton.frame.size = CGSize(width: 25, height: 25)
        //        likeButton.imageView?.contentMode = .scaleToFill
        
        
        NSLayoutConstraint.activate([
            
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            likeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            //            likeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            likeButton.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        
    }
    
    private func setupLabel() {
        
        addSubview(likeCounterLabel)
        
        likeCounterLabel.textColor = .red
        likeCounterLabel.textAlignment = .left
        likeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка AutoLayout
        NSLayoutConstraint.activate([
            
            likeCounterLabel.leadingAnchor.constraint(lessThanOrEqualTo: likeButton.trailingAnchor, constant: 5),
            likeCounterLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeCounterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
            
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
            likeCounter += 10000
            self.layoutIfNeeded()
            updateCountOfLikesLabel()
        } else {
            likeButton.tintColor = UIColor.white
            likeCounter += 10000
            self.layoutIfNeeded()
            updateCountOfLikesLabel()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        likeButton.frame = CGRect(x: 1, y: 0, width: 25, height: 25)
        //        self.layer.cornerRadius = self.frame.size.height / 2
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
