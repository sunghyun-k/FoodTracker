//
//  ViewController.swift
//  FoodTracker
//
//  Created by 김성현 on 17/07/2019.
//  Copyright © 2019 Sunghyun Kim. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
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
        
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 사용자가 취소하면 Picker를 없앱니다.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // info 딕셔너리는 여러 버전의 사진을 포함할 수 있습니다. 그 중 원본을 사용할 것입니다.
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("이미지가 포함된 딕셔너리를 예상했지만, \(info)가 제공되었습니다.")
        }
        
        // photoImageView에 선택된 이미지를 표시하도록 설정합니다.
        photoImageView.image = selectedImage
        
        // Picker를 없앱니다.
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // 키보드를 숨깁니다.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController는 사용자가 사진 보관함으로부터 미디어를 선택하도록 하는 View Controller입니다.
        let imagePickerController = UIImagePickerController()
        
        // 사진 촬영 말고 사진 선택만 가능하도록 합니다.
        imagePickerController.sourceType = .photoLibrary
        
        // 사용자가 이미지를 선택했을 때에 ViewController가 알림을 받도록 합니다.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
}

