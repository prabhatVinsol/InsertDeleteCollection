//
//  CollectionViewMethods.swift
//  InsertDeleteCollection
//
//  Created by Prabhat on 12/08/19.
//  Copyright © 2019 Prabhat. All rights reserved.
//

import Foundation
import UIKit
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ViewController.itemsList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? InsertDeleteCollectionViewCell
        cell?.val = Content(value: ViewController.itemsList[indexPath.row])
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UICollectionViewCell.transition(with: collectionView.cellForItem(at: indexPath)!, duration: TimeInterval(ViewController.animationDuration), options: .transitionFlipFromRight, animations: {
           ViewController.itemsList.remove(at: indexPath.row)
        }, completion: {finished in
           
             self.AlphabetCollectionView.deleteItems(at: [indexPath])
        })
       
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = ViewController.spaceBetweenItems * (ViewController.itemsPerRow + 1)*2
        let availableWidth = view.frame.width - CGFloat(integerLiteral: paddingSpace)
        let widthPerItem = availableWidth / CGFloat(integerLiteral: ViewController.itemsPerRow)

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(integerLiteral: ViewController.spaceBetweenItems), left: CGFloat(integerLiteral: ViewController.spaceBetweenItems), bottom: CGFloat(integerLiteral: ViewController.spaceBetweenItems), right: CGFloat(integerLiteral: ViewController.spaceBetweenItems))
    }
    
//    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 2*ViewController.spaceBetweenItems)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(integerLiteral: ViewController.spaceBetweenItems)
    }
}

extension ViewController: FinalSelection{
    func state(value: Int) {
        if value == 1{
            AlphabetCollectionView.reloadData()
        }
    }
    
    
}
