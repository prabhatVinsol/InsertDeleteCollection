import UIKit

protocol FinalSelection {
    func state(value:Int)
}

class ConfigurationViewController: UIViewController {
    @IBOutlet weak var animationSlider: UISlider!
    @IBOutlet weak var spacingPicker: UIPickerView!
    @IBOutlet weak var sizePicker: UIPickerView!
    @IBOutlet weak var sizeStackView: UIStackView!
    internal var finalSelectionDelegate: FinalSelection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizePicker.delegate = self
        sizePicker.dataSource = self
        spacingPicker.delegate = self
        spacingPicker.dataSource = self
        sizeStackView.isHidden = true
        initialiseSpacingPicker()
        initiliseSlider()
    }
   
    @IBAction func cancel(_ sender:UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
        guard let finalSelectionDelegateValue = finalSelectionDelegate else { return }
        finalSelectionDelegateValue.state(value: 1)
    }

    @IBAction func sliderHandling(_ sender: UISlider) {
        switch animationSlider.value {
        case 0:
            CollectionViewConfigurations.shared.animationDuration = 0
        case 0.1...0.25:
            CollectionViewConfigurations.shared.animationDuration = 4
        case 0.26...0.50:
            CollectionViewConfigurations.shared.animationDuration = 3
        case 0.51...0.75:
            CollectionViewConfigurations.shared.animationDuration = 2
        case 0.76...1.0:
            CollectionViewConfigurations.shared.animationDuration = 1
        default:
            return
        }
    }
}

extension ConfigurationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case spacingPicker:
            initialiseSpacingPicker()
            return CollectionViewConfigurations.shared.spacingPickerValue.count
        case sizePicker:
            return CollectionViewConfigurations.shared.sizePickerValue.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case spacingPicker:
            return "\(CollectionViewConfigurations.shared.spacingPickerValue[row])"
        case sizePicker:
            return "\(CollectionViewConfigurations.shared.sizePickerValue[row])"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == spacingPicker{
            sizeStackView.isHidden = false
            CollectionViewConfigurations.shared.spaceBetweenItems = CollectionViewConfigurations.shared.spacingPickerValue[row]
            initialseSizePicker()
            sizePicker.reloadAllComponents()
        } else if pickerView == sizePicker{
            CollectionViewConfigurations.shared.cellHeight = CGFloat(integerLiteral: CollectionViewConfigurations.shared.sizePickerValue[row])
        }
    }
}

extension ConfigurationViewController {
    private func initiliseSlider() {
        switch CollectionViewConfigurations.shared.animationDuration {
        case 0:
            animationSlider.setValue(0.0, animated: false)
        case 1:
            animationSlider.setValue(1.0, animated: false)
        case 2:
            animationSlider.setValue(0.75, animated: false)
        case 3:
            animationSlider.setValue(0.50, animated: false)
        case 4:
            animationSlider.setValue(0.25, animated: false)
        default:
            return
        }
    }
}

extension ConfigurationViewController {
    private func initialiseSpacingPicker() {
        CollectionViewConfigurations.shared.spacingPickerValue.removeAll()
        for i in 0...25 {
            CollectionViewConfigurations.shared.spacingPickerValue.append(i)
        }
    }
    
    private func initialseSizePicker() {
        let paddingSpace = CollectionViewConfigurations.shared.spaceBetweenItems * (CollectionViewConfigurations.shared.itemsPerRow + 1)*2
        let availableWidth = view.frame.width - CGFloat(integerLiteral: paddingSpace)
        let widthPerItem = Int(availableWidth / CGFloat(integerLiteral: CollectionViewConfigurations.shared.itemsPerRow))
        CollectionViewConfigurations.shared.sizePickerValue.removeAll()
        for i in 25...widthPerItem {
            CollectionViewConfigurations.shared.sizePickerValue.append(i)
        }
    }
}
