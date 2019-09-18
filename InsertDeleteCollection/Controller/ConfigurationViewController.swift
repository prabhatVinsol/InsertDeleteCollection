//
//  ConfigurationViewController.swift
//  InsertDeleteCollection
//
//  Created by Prabhat on 12/08/19.
//  Copyright © 2019 Prabhat. All rights reserved.
//

import UIKit

protocol FinalSelection {
    func state(value:Int)
}
class ConfigurationViewController: UIViewController {

    @IBOutlet weak var animationSlider: UISlider!
    
    @IBOutlet weak var spacingPicker: UIPickerView!
    
    @IBOutlet weak var sizePicker: UIPickerView!
    
    @IBOutlet weak var sizeStackView: UIStackView!
    
    static var spacingPickerValue = [Int]()
    static var sizePickerValue = [Int]()
    var finalSelectionDelegate: FinalSelection!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sizePicker.delegate = self
        sizePicker.dataSource = self
        
        spacingPicker.delegate = self
        spacingPicker.dataSource = self
        
        sizeStackView.isHidden = true
        
        
        
        initialiseSpacingPicker()
        initiliseSlider()
 
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
   
    
    //MARK:- All UIViews Actions
    @IBAction func cancel(_ sender:UIBarButtonItem){
        
        self.dismiss(animated: true, completion: nil)
        finalSelectionDelegate.state(value: 1)
    }

    @IBAction func sliderHandling(_ sender: UISlider){
        if animationSlider.value == 0{
            ViewController.animationDuration = 0
        }else if animationSlider.value <= 0.25{
            ViewController.animationDuration = 4
        }else if animationSlider.value <= 0.50{
            ViewController.animationDuration = 3
        }else if animationSlider.value <= 0.75{
            ViewController.animationDuration = 2
        }else{
            ViewController.animationDuration = 1
        }
    }
}
