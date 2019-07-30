//
//  ViewController.swift
//  FoodTracker
//
//  Created by 김성현 on 17/07/2019.
//  Copyright © 2019 Sunghyun Kim. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    /*
     이 값은 `prepare(for:sender:)`의 `MealTableViewController`를 통해 전달될 때 또는
     새로운 meal을 추가할 때 구성됩니다.
     */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Text Field의 사용자 입력을 델리게이트 콜백을 통해 처리합니다.
        nameTextField.delegate = self
        
        // 만약 존재하는 meal을 수정하는 것이라면 화면을 설정합니다.
        if let meal = meal {
            navigationItem.title = meal.name
            nameTextField.text = meal.name
            photoImageView.image = meal.photo
            ratingControl.rating = meal.rating
        }
        
        // 텍스트 필드가 유효한 이름을 가지고 있을 때에만 저장 버튼을 활성화합니다.
        updateSaveButtonState()
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 키보드를 숨깁니다.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 작성중일 때에는 저장 버튼을 비활성화합니다.
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
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
    
    //MARK: 네비게이션
    @IBAction func cancel(_ sender: Any) {
        
        // 표시된 스타일(모달 또는 푸시 프레젠테이션)에 따라 이 뷰 컨트롤러는 두 가지 방법으로 사라집니다.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("MealViewController는 네비게이션 컨트롤러 내부에 있지 않습니다.")
        }
    }
    
    // 이 메소드는 뷰 컨트롤러가 나타나기 전에 뷰 컨트롤러를 구성하도록 해줍니다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // 저장 버튼이 눌렸을 때에만 나타날 뷰 컨트롤러를 구성합니다.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("저장 버튼이 눌리지 않았음, 취소중...", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // 되감기 segue(unwind segue) 진행 전에 MealTableViewController로 전달될 meal을 설정합니다.
        meal = Meal(name: name, photo: photo, rating: rating)
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
    
    //MARK: 비공개 메소드
    
    private func updateSaveButtonState() {
        // 텍스트 필드가 비어있으면 저장 버튼을 비활성화합니다.
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

