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

    @IBAction func cancel(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction private func sliderHandling(_ sender: UISlider) {
        animationValue.text = "\(String(format: "%.1f", animationSlider.value))/5.0"
    }
    
    @IBAction private func saveButton(_ sender: Any) {
        guard let sizeValueOfField = sizeValue.text, let spacingValueOfField = spacingValue.text else {
            self.showAlert(with: "Enter Value", and: "Please enter size and spacing value.")
            return
        }
        let sizeToBeChecked = sizeValueOfField == "" ? Int(cellSize) : Int(sizeValueOfField)
        let spaceToBEchecked = spacingValueOfField == "" ? Int(cellSpacing) : Int(spacingValueOfField)
        if !handleInvalidValue(with: sizeToBeChecked ?? 100, and: spaceToBEchecked ?? 5) {
            return
        }
        handleDelegateWork()
    }

    private func initiliseSlider() {
        animationSlider.setValue(animationSpeedValue, animated: false)
        animationValue.text = "\(String(format: "%.1f", animationSpeedValue))/5.0"
        sizeValue.placeholder = "\(cellSize)"
        spacingValue.placeholder = String(cellSpacing)
    }
}

extension ConfigurationViewController {
    private func saveConfigurationValues(of size: Int, and spacing: Int) {
        CollectionViewConfigurations.shared.spaceBetweenItems = spacing
        let cellHeight = Float(size)
        CollectionViewConfigurations.shared.cellHeight = cellHeight
        CollectionViewConfigurations.shared.animationDuration = animationSlider.value
    }

    private func isValueInvalid(for sizeOrSpacing: Int) -> Bool {
        return (view.frame.width < CGFloat(integerLiteral: Int(sizeOrSpacing)) || sizeOrSpacing < 0)
    }

    private func handleDelegateWork() {
        guard let finalSelectionDelegateValue = finalSelectionDelegate else { return }
        finalSelectionDelegateValue.state(value: 1)
        self.dismiss(animated: true, completion: nil)
    }

    private func handleInvalidValue(with sizeToBeChecked: Int, and spaceToBEChecked: Int) -> Bool {
        if !(isValueInvalid(for: sizeToBeChecked) || isValueInvalid(for: spaceToBEChecked)){
            saveConfigurationValues(of: sizeToBeChecked, and: spaceToBEChecked)
            return true
        } else {
            self.showAlert(with: Constant.AlertTitles.invalidValueTitle, and: Constant.AlertMessages.invalidValueMessage)
            return false
        }
    }
}

extension UIViewController {
    internal func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
