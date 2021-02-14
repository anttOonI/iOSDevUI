//
//  FriendsPhotosCollectionViewController.swift
//  VKClient
//
//  Created by AntonSobolev on 04.11.2020.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendsPhotosCollectionVC: UICollectionViewController {
    
//    var photos: [String] = []
    private let downloadImage = DownloadImage()
    var friendPhoto = [Photo]()
    var friendId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        PhotoRequest.getAll(for: friendId, completion: { [weak self] photos in
                    self?.friendPhoto = photos
                    self?.collectionView.reloadData()
                })
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendPhoto.count
    }

    /*
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionCell", for: indexPath) as! FriendCollectionViewCell

     let photoObject = friendPhoto[indexPath.item]

     imageService.getPhoto(byURL: photoObject.sizes[0].url, completion: { photo in
         cell.friendPhotoImageView.image = photo
         cell.LikeControl.likeCounter = Float(photoObject.likes.likesCount)
         })
     */
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotosCell", for: indexPath) as! FriendsPhotosCollectionViewCell
        let photo = friendPhoto[indexPath.item]
        downloadImage.getPhoto(byURL: photo.sizes[0].url, completion: { photo in
            cell.friendPhotos.image = photo
            })
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let fullScreenVC = storyboard?.instantiateViewController(identifier: "FullScreenFriendPhotosVC") as! FullScreenFriendPhotosVC
        
//        fullScreenVC.photos =
//        fullScreenVC.indexPath = indexPath
        self.navigationController?.pushViewController(fullScreenVC, animated: true)
    }
}


