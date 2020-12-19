//
//  FullScreenFriendPhotosVC.swift
//  VKClient
//
//  Created by AntonSobolev on 26.11.2020.
//

import UIKit
class FullScreenFriendPhotosVC: UIViewController {
    
    var photos = [String]()
    var indexPath: IndexPath!
    let countCells = 1
    
    var items = [Int: FullScreenCollectionViewCell]()
    
    @IBOutlet weak var fullScreenCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullScreenCollectionView.delegate = self
        fullScreenCollectionView.dataSource = self
        
        fullScreenCollectionView.performBatchUpdates(nil, completion: {result in
            self.fullScreenCollectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: false)
        })
    }
    
}

extension FullScreenFriendPhotosVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = fullScreenCollectionView.dequeueReusableCell(withReuseIdentifier: "FullCollection", for: indexPath) as! FullScreenCollectionViewCell
        cell.fullScreenImageView.image = UIImage(named: photos[indexPath.item])
        
        self.items[indexPath.item] = cell
            
        return cell
    }
    
    
}
extension FullScreenFriendPhotosVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = fullScreenCollectionView.frame
        
        let widthCell = frameCV.width / CGFloat(countCells)
        let heightCell = widthCell
        
        return CGSize(width: widthCell, height: heightCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? FullScreenCollectionViewCell)?.hideImage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        var visibleRect = CGRect()
//
//        visibleRect.origin = fullScreenCollectionView.contentOffset
//        visibleRect.size = fullScreenCollectionView.bounds.size
//
//        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//
//        guard let indexPath = fullScreenCollectionView.indexPathForItem(at: visiblePoint) else { return }
//        let cell = fullScreenCollectionView.cellForItem(at: indexPath) as! FullScreenCollectionViewCell
//        UIView.animate(withDuration: 0.5,
//                       animations: {
//                        cell.fullScreenImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//                       })
//
//        print(indexPath)
        updateXLocation(scrollView.contentOffset.x)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        updateXLocation(scrollView.contentOffset.x)
    }

    func updateXLocation(_ xLocation: CGFloat) {
        
        let centerX = UIScreen.main.bounds.width / 2 + xLocation
        
        self.items.values.forEach {
            if $0.center.x == centerX {
                $0.showFullImage()
            }
        }
    }
    
}
