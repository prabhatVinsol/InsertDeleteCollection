import UIKit

class ViewController: UIViewController {
    private var reuseIdentifier = "collectionIdentifier"
    @IBOutlet weak var alphabetCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alphabetCollectionView.delegate = self
        alphabetCollectionView.dataSource = self
        alphabetCollectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as? UINavigationController
        let vc = nav?.topViewController as? ConfigurationViewController
        vc?.finalSelectionDelegate = self
    }
    
    @IBAction func allButtonsOperationHandling(_ sender: UIButton!) {
        switch sender.tag {
        case 1:
            insert3ItemAtEnd()
        case 2:
            delete3ItemAtEnd()
        case 3:
            updatingItemAtIndex2()
        case 4:
            moveEToEnd()
        case 5:
            insert3BeggingDelete3End()
        case 6:
            delete3beggingInsert3End()
        default:
            return
        }
    }
    
    @IBAction func navigationItemClick(_ sender: UIBarButtonItem!) {
        performSegue(withIdentifier: "ConfigurationSeague", sender: self)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionViewConfigurations.shared.itemsList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? InsertDeleteCollectionViewCell
        cell?.value = Content(value: CollectionViewConfigurations.shared.itemsList[indexPath.row])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UICollectionViewCell.transition(with: collectionView.cellForItem(at: indexPath)!, duration: TimeInterval(CollectionViewConfigurations.shared.animationDuration), options: .transitionFlipFromRight, animations: {
            CollectionViewConfigurations.shared.itemsList.remove(at: indexPath.row)
        }, completion: {finished in
            self.alphabetCollectionView.deleteItems(at: [indexPath])
        })
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = CollectionViewConfigurations.shared.spaceBetweenItems * (CollectionViewConfigurations.shared.itemsPerRow + 1)*2
        let availableWidth = view.frame.width - CGFloat(integerLiteral: paddingSpace)
        let widthPerItem = availableWidth / CGFloat(integerLiteral: CollectionViewConfigurations.shared.itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: CGFloat(integerLiteral: CollectionViewConfigurations.shared.spaceBetweenItems), left: CGFloat(integerLiteral: CollectionViewConfigurations.shared.spaceBetweenItems), bottom: CGFloat(integerLiteral: CollectionViewConfigurations.shared.spaceBetweenItems), right: CGFloat(integerLiteral: CollectionViewConfigurations.shared.spaceBetweenItems))
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 2*CollectionViewConfigurations.shared.spaceBetweenItems)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(integerLiteral: CollectionViewConfigurations.shared.spaceBetweenItems)
    }
    
}

extension ViewController: FinalSelection {
    func state(value: Int) {
        _ = value == 1 ? alphabetCollectionView.reloadData() : nil
    }
    
}

extension ViewController {
    private func insert3ItemAtEnd() {
        for i in 1...3 {
            CollectionViewConfigurations.shared.itemsList.append("\(i)")
            self.alphabetCollectionView.insertItems(at: [IndexPath(item: CollectionViewConfigurations.shared.itemsList.count-1, section: 0)])
        }
    }
    
    private func delete3ItemAtEnd() {
        for _ in 0..<3 {
            CollectionViewConfigurations.shared.itemsList.remove(at: CollectionViewConfigurations.shared.itemsList.count-1)
            self.alphabetCollectionView.deleteItems(at: [IndexPath(item:CollectionViewConfigurations.shared.itemsList.count, section: 0)])
        }
    }
    
    private func updatingItemAtIndex2() {
        CollectionViewConfigurations.shared.itemsList[2] = CollectionViewConfigurations.shared.itemsList[2] + "0"
        alphabetCollectionView.reloadItems(at: [IndexPath(item: 2, section: 0)])
    }
    
    private func moveEToEnd() {
        if CollectionViewConfigurations.shared.itemsList.contains("e") {
            var indexValue = -1
            for (index, value) in CollectionViewConfigurations.shared.itemsList.enumerated() {
                if value == "e" {
                    indexValue = index
                }
            }
            if indexValue != -1 {
                CollectionViewConfigurations.shared.itemsList.remove(at: indexValue)
                CollectionViewConfigurations.shared.itemsList.append("e")
                alphabetCollectionView.moveItem(at: IndexPath(item: indexValue, section: 0), to: IndexPath(item: CollectionViewConfigurations.shared.itemsList.count-1, section: 0))
            }
        }
    }
    
    private func delete3beggingInsert3End() {
        if CollectionViewConfigurations.shared.itemsList.count > 3 {
            alphabetCollectionView.performBatchUpdates( {
                delete3Operation(at: [0, 1, 2])
                let countAfterDelete = CollectionViewConfigurations.shared.itemsList.count
                insert3Operation(at: [countAfterDelete, countAfterDelete+1, countAfterDelete+2], end: 1)
            }, completion: nil)
        }
    }
    
    private func insert3BeggingDelete3End() {
        alphabetCollectionView.performBatchUpdates( {
            let countAfterDelete = CollectionViewConfigurations.shared.itemsList.count-1
            delete3Operation(at: [countAfterDelete, countAfterDelete-1, countAfterDelete-2])
            insert3Operation(at: [0, 1, 2], end: 0)
        }, completion: nil)
    }
    
    private func delete3Operation(at indexArray: [Int]) {
        for (_, value) in indexArray.enumerated() {
            CollectionViewConfigurations.shared.itemsList.remove(at: value)
            self.alphabetCollectionView.deleteItems(at: [IndexPath(item: value, section: 0)])
        }
    }
    
    private func insert3Operation(at indexArray: [Int], end:Int) {
        for (_, value) in indexArray.enumerated() {
            _ = end == 1 ? CollectionViewConfigurations.shared.itemsList.append("\(value)") : CollectionViewConfigurations.shared.itemsList.insert("\(value)", at: value)
            alphabetCollectionView.insertItems(at: [IndexPath(item: value, section: 0)])
        }
    }
}

