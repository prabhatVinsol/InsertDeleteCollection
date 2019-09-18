//
//  AllButtonClickHandling.swift
//  InsertDeleteCollection
//
//  Created by Prabhat on 12/08/19.
//  Copyright © 2019 Prabhat. All rights reserved.
//

import Foundation
extension ViewController{
    // All Button Actions
    
    func insert3ItemAtEnd(){
        ViewController.itemsList.append("1")
        ViewController.itemsList.append("2")
        ViewController.itemsList.append("3")
        self.AlphabetCollectionView.insertItems(at: [IndexPath(item: ViewController.itemsList.count-3, section: 0),
            IndexPath(item: ViewController.itemsList.count-2, section: 0),
            IndexPath(item: ViewController.itemsList.count-1, section: 0)])
    }
    
    func delete3ItemAtEnd(){
        ViewController.itemsList.remove(at: ViewController.itemsList.count-1)
        ViewController.itemsList.remove(at: ViewController.itemsList.count-1)
        ViewController.itemsList.remove(at: ViewController.itemsList.count-1)
        self.AlphabetCollectionView.deleteItems(at: [IndexPath(item:ViewController.itemsList.count+2, section: 0),
            IndexPath(item: ViewController.itemsList.count+1, section: 0),
            IndexPath(item: ViewController.itemsList.count, section: 0)])
    }
    
    func updatingItemAtIndex2(){
        
        ViewController.itemsList[2] = ViewController.itemsList[2] + "0"
        AlphabetCollectionView.reloadItems(at: [IndexPath(item: 2, section: 0)])
    }
    
    func moveEToEnd(){
        if ViewController.itemsList.contains("e"){
            var indexValue = -1
            for (index, value) in ViewController.itemsList.enumerated(){
                if value == "e"{
                    indexValue = index
                }
            }
            if indexValue != -1{
                ViewController.itemsList.remove(at: indexValue)
                ViewController.itemsList.append("e")
                AlphabetCollectionView.moveItem(at: IndexPath(item: indexValue, section: 0), to: IndexPath(item: ViewController.itemsList.count-1, section: 0))
            }
        }
        
    }
    func delete3beggingInsert3End(){
        if ViewController.itemsList.count > 3{
            
            AlphabetCollectionView.performBatchUpdates({
                delete3Operation(at: 0, 1, 2)
                var countAfterDelete = ViewController.itemsList.count
                insert3Operation(at: countAfterDelete, countAfterDelete+1, countAfterDelete+2, end: 1)
                
            }, completion: nil)
        }
        
    }
    
    func insert3BeggingDelete3End(){
        AlphabetCollectionView.performBatchUpdates({
            var countAfterDelete = ViewController.itemsList.count-1
            delete3Operation(at: countAfterDelete, countAfterDelete-1, countAfterDelete-2)
            insert3Operation(at: 0, 1, 2, end: 0)
          
            
        }, completion: nil)
    }
    
    func delete3Operation(at firstIndex:Int, _ secondIndex:Int, _ thirdIndex:Int){
      
        ViewController.itemsList.remove(at: firstIndex)
        ViewController.itemsList.remove(at: secondIndex)
        ViewController.itemsList.remove(at: thirdIndex)
        AlphabetCollectionView.deleteItems(at: [IndexPath(item: firstIndex, section: 0),
                                           IndexPath(item: secondIndex, section: 0),
                                            IndexPath(item: thirdIndex, section: 0)])
    }
    func insert3Operation(at firstIndex:Int, _ secondIndex:Int, _ thirdIndex:Int, end:Int){
        if end == 1{
            ViewController.itemsList.append("\(firstIndex)")
            ViewController.itemsList.append("\(secondIndex)")
            ViewController.itemsList.append("\(thirdIndex)")
        }else{
           
            ViewController.itemsList.insert("\(firstIndex)", at: firstIndex)
            ViewController.itemsList.insert("\(secondIndex)", at: secondIndex)
            ViewController.itemsList.insert("\(thirdIndex)", at: thirdIndex)
        }
    
        AlphabetCollectionView.insertItems(at: [IndexPath(item: firstIndex, section: 0),
                                                IndexPath(item: secondIndex, section: 0),
                                                IndexPath(item: thirdIndex, section: 0)])
    }
}
