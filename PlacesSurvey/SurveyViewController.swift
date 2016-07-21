//
//  SurveyViewController.swift
//  PlacesSurvey
//
//  Created by Brad on 7/21/16.
//  Copyright © 2016 Brad Forsyth. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func submitButtonTapped(sender: AnyObject) {
        guard let name = nameTextField.text, response = placeTextField.text where nameTextField.text?.characters.count > 0 && placeTextField.text?.characters.count > 0 else { return }
        SurveyController.putSurveyIntoAPI(name, response: response)
        
        nameTextField.text = ""
        placeTextField.text = ""
        nameTextField.resignFirstResponder()
        placeTextField.resignFirstResponder()
    }
}