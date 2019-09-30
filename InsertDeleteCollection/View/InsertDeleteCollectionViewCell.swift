import UIKit

class InsertDeleteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    var value: Content?{
        didSet{
            guard let contentValue = value else { return }
            setvalueToLabel(with: contentValue)
        }
    }
    
    private func setvalueToLabel(with contentValue: Content) {
        testLabel.text = contentValue.value
    }
    
}
