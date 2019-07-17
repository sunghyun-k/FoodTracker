//
//  ViewController.swift
//  FoodTracker
//
//  Created by 김성현 on 17/07/2019.
//  Copyright © 2019 Sunghyun Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Text Field의 사용자 입력을 델리게이트 콜백을 통해 처리합니다.
        nameTextField.delegate = self
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 키보드를 숨깁니다.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    
    //MARK: Actions
    @IBAction func setDefaultLabelText(_ sender: UIButton) {
        mealNameLabel.text = "Default Text"
    }
}

