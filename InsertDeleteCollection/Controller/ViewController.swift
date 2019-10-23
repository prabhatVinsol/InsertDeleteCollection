import UIKit

class ViewController: UIViewController {
    private var reuseIdentifier = "collectionIdentifier"
    private var characterArray = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    private var section = 0
    @IBOutlet private weak var alphabetCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alphabetCollectionView.delegate = self
        alphabetCollectionView.dataSource = self
        alphabetCollectionView.reloadData()
        Layout.shared.numberOfItemsPerRow(forAvailable: view.frame.width)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nav = segue.destination as? UINavigationController
        let vc = nav?.topViewController as? ConfigurationViewController
        vc?.finalSelectionDelegate = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        Layout.shared.numberOfItemsPerRow(forAvailable: size.width)
    }
    @IBAction private func allButtonsOperationHandling(_ sender: UIButton!) {
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
    
    @IBAction private func navigationItemClick(_ sender: UIBarButtonItem!) {
        performSegue(withIdentifier: "ConfigurationSeague", sender: self)
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? InsertDeleteCollectionViewCell
        cell?.value = Content(value: characterArray[indexPath.row])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UICollectionViewCell.transition(with: collectionView.cellForItem(at: indexPath)!, duration: TimeInterval(CollectionViewConfigurations.shared.animationDuration ?? 4), options: .transitionFlipFromRight, animations: {
            self.characterArray.remove(at: indexPath.row)
        }, completion: { finished in
            self.alphabetCollectionView.deleteItems(at: [indexPath])
        })
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Layout.shared.cellWidthAndHeight()
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.shared.interSpaceOfCellsColumn()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.shared.interSpacingOfCells(ofAvailable: view.frame.width)/2
    }
    
}

extension ViewController: FinalSelection {
    func state(value: Int) {
        Layout.shared.numberOfItemsPerRow(forAvailable: view.frame.width)
        if value == 1 {
            alphabetCollectionView.reloadData()
        }
    }
    
}

extension ViewController {
    private func insert3ItemAtEnd() {
        for i in 1...3 {
            characterArray.append("\(i)")
            self.alphabetCollectionView.insertItems(at: [IndexPath(item: characterArray.count-1, section: section)])
        }
    }
    
    private func delete3ItemAtEnd() {
        for _ in 0..<3 {
            characterArray.remove(at: characterArray.count-1)
            self.alphabetCollectionView.deleteItems(at: [IndexPath(item:characterArray.count, section: section)])
        }
    }
    
    private func updatingItemAtIndex2() {
        characterArray[2] = characterArray[2] + "0"
        alphabetCollectionView.reloadItems(at: [IndexPath(item: 2, section: section)])
    }
    
    private func moveEToEnd() {
        if characterArray.contains("e") {
            var indexValue = -1
            for (index, value) in characterArray.enumerated() {
                if value == "e" {
                    indexValue = index
                }
            }
            if indexValue != -1 {
                characterArray.remove(at: indexValue)
                characterArray.append("e")
                alphabetCollectionView.moveItem(at: IndexPath(item: indexValue, section: section), to: IndexPath(item: characterArray.count-1, section: section))
            }
        }
    }
    
    private func delete3beggingInsert3End() {
        if characterArray.count > 3 {
            alphabetCollectionView.performBatchUpdates( {
                delete3Operation(at: [0, 1, 2])
                let countAfterDelete = characterArray.count
                insert3Operation(at: [countAfterDelete, countAfterDelete+1, countAfterDelete+2], end: 1)
            }, completion: nil)
        }
    }
    
    private func insert3BeggingDelete3End() {
        alphabetCollectionView.performBatchUpdates( {
            let countAfterDelete = characterArray.count-1
            delete3Operation(at: [countAfterDelete, countAfterDelete-1, countAfterDelete-2])
            insert3Operation(at: [0, 1, 2], end: 0)
        }, completion: nil)
    }
    
    private func delete3Operation(at indexArray: [Int]) {
        for (_, value) in indexArray.enumerated() {
            characterArray.remove(at: value)
            self.alphabetCollectionView.deleteItems(at: [IndexPath(item: value, section: section)])
        }
    }
    
    private func insert3Operation(at indexArray: [Int], end:Int) {
        for (_, value) in indexArray.enumerated() {
            _ = end == 1 ? characterArray.append("\(value)") : characterArray.insert("\(value)", at: value)
            alphabetCollectionView.insertItems(at: [IndexPath(item: value, section: section)])
        }
    }
}

