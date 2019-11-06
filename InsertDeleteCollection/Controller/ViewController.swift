import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var alphabetCollectionView: UICollectionView! {
        didSet {
            alphabetCollectionView.delegate = self
            alphabetCollectionView.dataSource = self
        }
    }

    private var characterArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    private let section = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
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

    private func initialSetUp() {
        Layout.shared.numberOfItemsPerRow(forAvailable: view.frame.width)
        alphabetCollectionView.reloadData()
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
            insert3AtBeginingDelete3AtEnd()
        case 6:
            delete3AtBeginingInsert3AtEnd()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.ReuseIdentifiers.alphaCollCellIdentifier, for: indexPath) as? InsertDeleteCollectionViewCell
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
        var indexPathArray = [IndexPath]()
        for i in 1...3 {
            indexPathArray.append(IndexPath(item: characterArray.count, section: section))
            characterArray.append("\(i)")
        }
        self.alphabetCollectionView.insertItems(at: indexPathArray)
    }

    private func delete3ItemAtEnd() {
        var indexPathArray = [IndexPath]()
        for _ in 0..<3 {
            if characterArray.isEmpty { break }
            characterArray.removeLast()
            indexPathArray.append(IndexPath(item: characterArray.count, section: section))
        }
        self.alphabetCollectionView.deleteItems(at: indexPathArray)
    }

    private func updatingItemAtIndex2() {
        if characterArray.count < 3 {
            self.showAlert(with: Constant.AlertTitles.indexNotFoundTitle, and: Constant.AlertMessages.indexNotFoundMessage)
            return
        }
        characterArray[2] = characterArray[2] + "0"
        alphabetCollectionView.reloadItems(at: [IndexPath(item: 2, section: section)])
    }

    private func moveEToEnd() {
        let index = characterArray.index(of: "E")
        guard let indexValue = index else {
            self.showAlert(with: Constant.AlertTitles.valueNotFoundTitle, and: Constant.AlertMessages.valueNotFoundMessage)
            return
        }
        characterArray.remove(at: indexValue)
        characterArray.append("E")
        alphabetCollectionView.moveItem(at: IndexPath(item: indexValue, section: section), to: IndexPath(item: characterArray.count-1, section: section))
    }

    private func delete3AtBeginingInsert3AtEnd() {
        if characterArray.count < 3 { return }
        alphabetCollectionView.performBatchUpdates( {
            delete3Operation(of: [0, 1, 2], at: false)
            let countAfterDelete = characterArray.count
            insert3Operation(at: [countAfterDelete, countAfterDelete+1, countAfterDelete+2])
        }, completion: nil)
    }

    private func insert3AtBeginingDelete3AtEnd() {
        if characterArray.isEmpty { return }
        alphabetCollectionView.performBatchUpdates( {
            delete3Operation(of: indexesToBeDeletedAtEnd(count: characterArray.count), at: true)
            insert3Operation(at: [0, 1, 2])
        }, completion: nil)
    }

    private func indexesToBeDeletedAtEnd(count: Int) -> [Int] {
        return count < 3 ? arrayLessThanThree(ofCount: count) : arraySize(ofCount: count)
    }

    private func arrayLessThanThree(ofCount count: Int) -> [Int] {
        var indexArray = [Int]()
        for i in 0..<count {
            indexArray.append(i)
        }
        return indexArray
    }

    private func arraySize(ofCount count: Int) -> [Int] {
        return [count-1, count-2, count-3]
    }

    private func delete3Operation(of indexArray: [Int], at isEnd: Bool) {
        var indexPathArray = [IndexPath]()
        for (_, value) in indexArray.enumerated() {
            removeElementFromCollection(at: isEnd)
            indexPathArray.append(IndexPath(item: value, section: section))
        }
        self.alphabetCollectionView.deleteItems(at: indexPathArray)
    }

    private func removeElementFromCollection(at end: Bool) {
        if end {
            characterArray.removeLast()
        } else {
            characterArray.removeFirst()
        }
    }

    private func insert3Operation(at indexArray: [Int]) {
        var indexPathArray = [IndexPath]()
        for (_, value) in indexArray.enumerated() {
            indexPathArray.append(IndexPath(item: value, section: section))
            characterArray.insert("\(value)", at: value)
        }
        self.alphabetCollectionView.insertItems(at: indexPathArray)
    }
}

