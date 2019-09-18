//
//  ViewController.swift
//  InsertDeleteCollection
//
//  Created by Prabhat on 12/08/19.
//  Copyright © 2019 Prabhat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    static var itemsPerRow = 4
    static var itemsList = ["a","b","c","d","e","f","g","h",
                            "i","j","k","l","m","n","o","p",
                            "q","r","s","t","u","v","w","x",
                            "y","z"]
    
    static var spaceBetweenItems = 5
    var reuseIdentifier = "collectionIdentifier"
    static var cellHeight = CGFloat(integerLiteral: 100)
    static var animationDuration = 4
    @IBOutlet weak var AlphabetCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        AlphabetCollectionView.delegate = self
        AlphabetCollectionView.dataSource = self
        AlphabetCollectionView.reloadData()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as? UINavigationController
        let vc = nav?.topViewController as? ConfigurationViewController
        vc?.finalSelectionDelegate = self
    }


    //MARK:- all button Actions
    
    @IBAction func allOperationHandling(_ sender: UIButton!){
        
        if sender.tag == 1{
            insert3ItemAtEnd()
        }else if sender.tag == 2{
            delete3ItemAtEnd()
        }else if sender.tag == 3{
            updatingItemAtIndex2()
        }else if sender.tag == 4{
            moveEToEnd()
        }else if sender.tag == 5{
            delete3beggingInsert3End()
        }else if sender.tag == 6{
            insert3BeggingDelete3End()
        }
        
    }
    
    @IBAction func navigationItemClick(_ sender: UIBarButtonItem!){
        performSegue(withIdentifier: "ConfigurationSeague", sender: self)
    }
}

