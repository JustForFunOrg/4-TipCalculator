//
//  ViewController.swift
//  TipCalculator
//
//  Created by vmalikov on 1/30/16.
//  Copyright © 2016 justForFun. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipResultLabel: UILabel!
    @IBOutlet weak var totalResultLabel: UILabel!
    
    @IBOutlet weak var tipPercentSlider: UISlider!
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.delegate = self
        amountTextField.resignFirstResponder()
        addDoneButtonToKeyboard()
    }
    
    // MARK: Keyboard
    func addDoneButtonToKeyboard() {
        let numberToolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 50))
        numberToolbar.barStyle = UIBarStyle.Default
        
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "keyboardDoneButtonTapped")]
        
        numberToolbar.sizeToFit()
        amountTextField.inputAccessoryView = numberToolbar
    }
    
    func keyboardDoneButtonTapped() {
        amountTextField.endEditing(true)
        textFieldDidEndEditing(amountTextField)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        amountTextField.resignFirstResponder()
    }

    
    // MARK: Helpers
    func updateTipPersentLabel() {
        let percentValue = Int(tipPercentSlider.value)
        tipPercentLabel.text = "Tip (\(percentValue)%)"
    }
    
    func updateTipResultLabel() {
        tipResultLabel.text = "\(getTipAmount().formatWithDefaultValue())"
    }
    
    func updateTotalLabel() {
        totalResultLabel.text = "\(getCalculatedTotal().formatWithDefaultValue())"
    }

    
    @IBAction func percentSliderValueChanged(sender: UISlider) {
        updateTipPersentLabel()
        updateTipResultLabel()
        updateTotalLabel()
    }
    
    func getTipAmount() -> Float {
        let percent = floor(tipPercentSlider.value)
        return getAmount() * (percent / 100)
    }
    
    func getAmount() -> Float {
        guard var amountString = amountTextField.text where amountString.characters.count > 0 else {
            return 0
        }
        
        amountString = amountString.stringByReplacingOccurrencesOfString("$", withString: "")
        
        if let amount = Float(amountString) {
            return amount
        } else {
            return 0
        }
    }
    
    func getCalculatedTotal() -> Float {
        return getAmount() + getTipAmount()
    }

}

// MARK: - UITextFieldDelegate
extension MainViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.text = "\(getAmount().formatWithDefaultValue())"
        
        updateTipPersentLabel()
        updateTipResultLabel()
        updateTotalLabel()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}


