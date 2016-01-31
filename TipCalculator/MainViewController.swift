//
//  ViewController.swift
//  TipCalculator
//
//  Created by vmalikov on 1/30/16.
//  Copyright © 2016 justForFun. All rights reserved.
//

import UIKit

extension Float {
    func format(f: String) -> String {
        return NSString(format: "$%\(f)f", self) as String
    }
}

class MainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var sumLabel: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipResultLabel: UILabel!
    @IBOutlet weak var totalResultLabel: UILabel!
    
    @IBOutlet weak var tipPercentSlider: UISlider!
    
    let defaultFormatForFloat = ".2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sumLabel.delegate = self
        sumLabel.resignFirstResponder()
        
        let numberToolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 50))
        numberToolbar.barStyle = UIBarStyle.Default
        
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "keyboardDoneButtonTapped")]
        
        numberToolbar.sizeToFit()
        sumLabel.inputAccessoryView = numberToolbar
    }
    
    func keyboardDoneButtonTapped() {
        textFieldDidEndEditing(sumLabel)
        sumLabel.endEditing(true)
    }
    
    @IBAction func percentSliderValueChanged(sender: UISlider) {
        let percentValue = Int(sender.value)
        tipPercentLabel.text = "Tip (\(percentValue)%)"
        
        updateTipResultLabel()
        updateTotalLabel()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        guard var sumText = textField.text where sumText.characters.count > 0 else {
            return
        }
        
        
        let asRange = sumText.rangeOfString("$")
        if let asRange = asRange where asRange.startIndex == sumText.startIndex {
            sumText.removeAtIndex(sumText.startIndex.advancedBy(0))
        }
        
        let enteredSum = Float(sumText)
        textField.text = "\(enteredSum!.format(defaultFormatForFloat))"

        updateTipResultLabel()
        updateTotalLabel()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sumLabel.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        sumLabel.resignFirstResponder()
    }
    
    func updateTipResultLabel() {
        tipResultLabel.text = "\(getTipAmount().format(defaultFormatForFloat))"
    }
    
    func updateTotalLabel() {
        totalResultLabel.text = "\(getCalculatedTotal().format(defaultFormatForFloat))"
    }
    
    func getTipAmount() -> Float {
        
        let percent = tipPercentSlider.value
        return getSumAmount() * (percent / 100)
    }
    
    func getCalculatedTotal() -> Float {
        return getSumAmount() + getTipAmount()
    }
    
    func getSumAmount() -> Float {
        guard let text = sumLabel.text  where text.characters.count > 0 else {
            return 0
        }
        
        let sumText = text.substringFromIndex(text.startIndex.advancedBy(1))
        
        guard let sum = Float(sumText) else {
            return 0
        }
        return sum
    }
}


