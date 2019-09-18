//
//  InsertDeleteCollectionViewCell.swift
//  InsertDeleteCollection
//
//  Created by Prabhat on 12/08/19.
//  Copyright © 2019 Prabhat. All rights reserved.
//

import UIKit

class InsertDeleteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    
    var val: Content?{
        didSet{
            testLabel.text = val?.value
        }
    }
}
