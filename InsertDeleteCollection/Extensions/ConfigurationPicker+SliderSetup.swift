//
//  ConfigurationPicker.swift
//  InsertDeleteCollection
//
//  Created by Prabhat on 12/08/19.
//  Copyright © 2019 Prabhat. All rights reserved.
//

import Foundation
import UIKit
extension ConfigurationViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == spacingPicker{
            initialiseSpacingPicker()
            return ConfigurationViewController.spacingPickerValue.count
        }else if pickerView == sizePicker{
            return ConfigurationViewController.sizePickerValue.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == spacingPicker{
            return "\(ConfigurationViewController.spacingPickerValue[row])"
        }else {
            return "\(ConfigurationViewController.sizePickerValue[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == spacingPicker{
            sizeStackView.isHidden = false
            ViewController.spaceBetweenItems = ConfigurationViewController.spacingPickerValue[row]
            initialseSizePicker()
            sizePicker.reloadAllComponents()
        }else if pickerView == sizePicker{
            ViewController.cellHeight = CGFloat(integerLiteral: ConfigurationViewController.sizePickerValue[row])
        }
    }
}

extension ConfigurationViewController{
    
    func initiliseSlider(){
        if ViewController.animationDuration == 0{
            animationSlider.setValue(0.0, animated: false)
        }else if ViewController.animationDuration == 1 {
            animationSlider.setValue(1.0, animated: false)
        }else if ViewController.animationDuration == 2 {
            animationSlider.setValue(0.75, animated: false)
        }else if ViewController.animationDuration == 3 {
            animationSlider.setValue(0.50, animated: false)
        }else if ViewController.animationDuration == 4 {
            animationSlider.setValue(0.25, animated: false)
        }
    }
}

extension ConfigurationViewController{
    
    func initialiseSpacingPicker(){
        ConfigurationViewController.spacingPickerValue.removeAll()
        
        for i in 0...25{
            ConfigurationViewController.spacingPickerValue.append(i)
        }
    }
    
    func initialseSizePicker(){
        let paddingSpace = ViewController.spaceBetweenItems * (ViewController.itemsPerRow + 1)*2
        let availableWidth = view.frame.width - CGFloat(integerLiteral: paddingSpace)
        let widthPerItem = Int(availableWidth / CGFloat(integerLiteral: ViewController.itemsPerRow))
        
        ConfigurationViewController.sizePickerValue.removeAll()
        for i in 25...widthPerItem{
            ConfigurationViewController.sizePickerValue.append(i)
        }
    }
}
