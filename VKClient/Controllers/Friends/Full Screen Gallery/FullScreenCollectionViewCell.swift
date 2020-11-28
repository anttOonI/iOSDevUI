//
//  FullScreenCollectionViewCell.swift
//  VKClient
//
//  Created by AntonSobolev on 26.11.2020.
//

import UIKit

class FullScreenCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fullScreenImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        self.fullScreenImageView.image = nil
//        self.fullScreenImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
}
