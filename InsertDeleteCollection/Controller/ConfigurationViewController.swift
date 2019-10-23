import UIKit

protocol FinalSelection {
    func state(value:Int)
}

class ConfigurationViewController: UIViewController {
    @IBOutlet private weak var animationSlider: UISlider!
    @IBOutlet private weak var animationValue: UILabel!
    @IBOutlet private weak var sizeValue: UITextField!
    @IBOutlet private weak var spacingValue: UITextField!
    private var animationSpeedValue = CollectionViewConfigurations.shared.animationDuration ?? 1
    private var cellSize = CollectionViewConfigurations.shared.cellHeight ?? 100
    private var cellSpacing = CollectionViewConfigurations.shared.spaceBetweenItems ?? 5
    private var itemsPerRow = CollectionViewConfigurations.shared.itemsPerRow
    internal var finalSelectionDelegate: FinalSelection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiliseSlider()
    }
    
    private func initiliseSlider() {
        animationSlider.setValue(animationSpeedValue, animated: false)
        animationValue.text = "\(String(format: "%.1f", animationSpeedValue))/5.0"
        sizeValue.placeholder = "\(cellSize)"
        spacingValue.placeholder = String(cellSpacing)
    }
   
    @IBAction func cancel(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func sliderHandling(_ sender: UISlider) {
        animationValue.text = "\(String(format: "%.1f", animationSlider.value))/5.0"

    }
    
    @IBAction private func saveButton(_ sender: Any) {
        //Assign to shared value
        guard let sizeValueOfField = sizeValue.text, let spacingValueOfField = spacingValue.text else {
            //Show Alert that check value of size and spacing
            return
        }
        let sizeToBeChecked = sizeValueOfField == "" ? Int(cellSize) : Int(sizeValueOfField)
        let spaceToBEchecked = spacingValueOfField == "" ? Int(cellSpacing) : Int(spacingValueOfField)
        if checkInvalidValues(of: sizeToBeChecked ?? 100) && checkInvalidValues(of: spaceToBEchecked ?? 5) {
            saveConfigurationValues(of: sizeToBeChecked ?? 100, and: spaceToBEchecked ?? 5)
        } else {
            // Show alert for invalid value of the fields
        }
        guard let finalSelectionDelegateValue = finalSelectionDelegate else { return }
        finalSelectionDelegateValue.state(value: 1)
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ConfigurationViewController {
    private func saveConfigurationValues(of size: Int, and spacing: Int) {
        let spacingValue = Int(spacing)
        CollectionViewConfigurations.shared.spaceBetweenItems = spacingValue
        let cellHeight = Float(size)
        CollectionViewConfigurations.shared.cellHeight = cellHeight
        CollectionViewConfigurations.shared.animationDuration = animationSlider.value
    }
    
    private func checkInvalidValues(of sizeOrSpacing: Int) -> Bool {
        return view.frame.width > CGFloat(integerLiteral: Int(sizeOrSpacing))
    }
}
