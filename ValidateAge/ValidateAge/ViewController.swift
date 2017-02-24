//
//  ViewController.swift
//  Tutorials
//
//  Created by John Xiong on 2/23/17.
//  Copyright © 2017 Xiong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Age of 18.
    let MINIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!;
    
    // Age of 100.
    let MAXIMUM_AGE: Date = Calendar.current.date(byAdding: .year, value: -100, to: Date())!;
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func validateButtonPressed(_ sender: Any) {
        let isValidAge = validateAge(birthDate: datePicker.date);
        
        if isValidAge {
            showAlert(title: "Valid Age", message: "You are between 18 and 100 years old");
        } else {
            showAlert(title: "Invalid Age", message: "Must be between 18 and 100 years old");
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func validateAge(birthDate: Date) -> Bool {
        var isValid: Bool = true;
        
        if birthDate < MAXIMUM_AGE || birthDate > MINIMUM_AGE {
            isValid = false;
        }
        
        return isValid;
    }
    
    func showAlert(title: String, message: String) {
        // Create alert controller.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        // Create alert action to add to controller.
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil);
        
        // Add action.
        alertController.addAction(alertAction);
        
        // Display alert.
        self.present(alertController, animated: true, completion: nil);
    }
}

