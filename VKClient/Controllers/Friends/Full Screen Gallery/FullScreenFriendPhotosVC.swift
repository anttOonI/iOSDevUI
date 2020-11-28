//
//  FullScreenFriendPhotosVC.swift
//  VKClient
//
//  Created by AntonSobolev on 26.11.2020.
//

import UIKit

class FullScreenFriendPhotosVC: UIViewController {
    
    var photos = [String]()
//    var selectedItem = 0
    var indexPath: IndexPath!
    
    let countCells = 1

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
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = fullScreenCollectionView.dequeueReusableCell(withReuseIdentifier: "FullCollection", for: indexPath) as! FullScreenCollectionViewCell
        cell.fullScreenImageView.image = UIImage(named: photos[indexPath.item])
//        print("----------------\(photos[indexPath.row])---------------")

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
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("Will Display - \(indexPath.item)")
//        let myreact = cell.frame
//                cell.frame = CGRect(x: cell.frame.origin.x+320, y: cell.frame.origin.y, width: cell.frame.size.width, height: cell.frame.size.height)
//
//                 let value = Double(indexPath.row)*0.1
//                 UIView.animate(withDuration: 0.5, delay:value, options: .curveEaseInOut, animations: {
//
//                    cell.frame = CGRect(x: myreact.origin.x+100, y: myreact.origin.y, width: myreact.size.width, height: myreact.size.height)
//
//                 }) { (finish) in
//
//                    UIView.animate(withDuration: 0.5, animations: {
//                        cell.frame = myreact
//                    })
//                }
//            }
//    }
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("Did end displaying - \(indexPath.item)")
//        UIView.animate(withDuration: 0.3,
//                       animations: {
//                        cell.transform = .identity
//                       } )
//    }
    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("scrollViewWillBeginDragging - \(indexPath.item)")
//        let cell = fullScreenCollectionView.visibleCells[indexPath.row]
//        UIView.animate(withDuration: 0.5, animations: {
//            cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//        })
//    }
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        let cell = fullScreenCollectionView.visibleCells[indexPath.row]
//        UIView.animate(withDuration: 0.5, animations: {
//            cell.transform = .identity
//        })
//    }
}
