//
//  FriendsPhotosCollectionViewController.swift
//  VKClient
//
//  Created by AntonSobolev on 04.11.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendsPhotosCollectionVC: UICollectionViewController {
    
    var photos: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotosCell", for: indexPath) as! FriendsPhotosCollectionViewCell
        let photo = photos[indexPath.item]
        cell.friendPhotos.image = UIImage(named: photo)
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let fullScreenVC = storyboard?.instantiateViewController(identifier: "FullScreenFriendPhotosVC") as! FullScreenFriendPhotosVC
        
        fullScreenVC.photos = photos
        fullScreenVC.indexPath = indexPath
        self.navigationController?.pushViewController(fullScreenVC, animated: true)
    }
}


