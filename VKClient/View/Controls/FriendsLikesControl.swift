//
//  LikeControl.swift
//  VKClient
//
//  Created by AntonSobolev on 09.11.2020.
//

import UIKit

class FriendsLikesControl: UIControl {
    
    var likeButton = UIButton()
    var likeCounterLabel = UILabel()
    var likeCounter: Float = 0
    var didLike = false
    
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
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    
    func setupButton() {
        
        addSubview(likeButton)
        
        likeButton.setImage(UIImage(named: "Thumbs50")?.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        likeButton.addTarget(self, action: #selector(tapLikeControl), for: .touchUpInside)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            likeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            likeButton.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        
    }
    
    func setupLabel() {
        
        addSubview(likeCounterLabel)
        
        likeCounterLabel.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        likeCounterLabel.textAlignment = .left
        likeCounterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Настройка AutoLayout
        NSLayoutConstraint.activate([
            
            likeCounterLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 5),
            likeCounterLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            likeCounterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            likeCounterLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 15)
        ])
        
        updateCountOfLikesLabel()
    }
    
    private func updateCountOfLikesLabel() {
        
        var tempValue: String = ""
        
        switch likeCounter {
        case 0...999:
        tempValue = String(Int(likeCounter))
        case 1000...999_999:
//            likeCounterLabel.text = String(likeCounter / 1000) + "k"
            tempValue = String(likeCounter / 1000) + "k"
        case 1_000_000...1_000_000_000:
//            likeCounterLabel.text = String(format: "%0.1f", (likeCounter / 1_000_000)) + "M"
            tempValue = String(format: "%0.1f", likeCounter / 1_000_000) + "M"

        default:
            likeCounterLabel.text = "x"
        }
        
//        UIView.animate(withDuration: 0.2,
//                       animations: {
//                        self.likeCounterLabel.frame.origin.y += 20
//                       })
        UIView.transition(with: likeCounterLabel,
                          duration: 0.3,
                          options: .transitionFlipFromTop,
                          animations: { [unowned self] in
                              self.likeCounterLabel.text = tempValue
                          })
    }
    
    
    @objc func tapLikeControl() {
        
        didLike = !didLike
        
        if didLike {
            likeButton.tintColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            likeCounter += 1
            self.layoutIfNeeded()
            updateCountOfLikesLabel()
        } else {
            likeButton.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            likeCounter -= 1
            self.layoutIfNeeded()
            updateCountOfLikesLabel()
        }
        

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("Вызвался layuotSubviews \(bounds)")
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
 
