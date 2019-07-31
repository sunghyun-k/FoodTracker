//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by 김성현 on 25/07/2019.
//  Copyright © 2019 Sunghyun Kim. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: 프로퍼티
    
    var meals = [Meal]()
    
    //MARK: 액션
    
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            if let seletedIndexPath = tableView.indexPathForSelectedRow {
                // 기존 meal을 업데이트합니다.
                meals[seletedIndexPath.row] = meal
                tableView.reloadRows(at: [seletedIndexPath], with: .none)
            } else {
                // 새로운 meal을 추가합니다.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            // meal을 저장합니다.
            saveMeals()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테이블 뷰 컨트롤러가 제공하는 수정 버튼을 사용합니다.
        // navigationItem.leftBarButtonItem = editButtonItem
        
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetButtonTapped))
        
        navigationItem.leftBarButtonItems = [editButtonItem, resetButton]
        
        // 저장된 meal을 로드합니다. 로드하지 못했다면 샘플 데이터를 로드합니다.
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            // 샘플 데이터를 로드합니다.
            loadSampleMeals()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 테이블 뷰 셀은 재사용되고 샐 ID를 사용하여 큐에서 제거되어야 합니다. Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("큐에서 제거된 셀은 MealTableViewCell의 인스턴스가 아닙니다.")
        }
        
        // 데이터 소스 레이아웃을 위한 적합한 meal을 가져옵니다.
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "AddItem":
            os_log("새로운 meal을 추가하는 중", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("예상치 못한 destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("예상치 못한 sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("선택된 셀은 테이블에 의해 표시되고 있지 않습니다.")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
        default:
            fatalError("예상치 못한 segue ID: \(segue.identifier)")
        }
    }
    
    //MARK: 비공개 메소드
    
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("meal1의 인스턴스화를 할 수 없습니다.")
        }
        
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
            fatalError("meal2의 인스턴스화를 할 수 없습니다.")
        }
        
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("meal3의 인스턴스화를 할 수 없습니다.")
        }
        
        meals += [meal1, meal2, meal3]
    }
    
    private func saveMeals() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
            try data.write(to: Meal.ArchiveURL)
            os_log("Meal이 성공적으로 저장됨.", log: OSLog.default, type: .debug)
        } catch {
            os_log("Meal 저장에 실패함...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeals() -> [Meal]? {
        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(Data(contentsOf: Meal.ArchiveURL)) as? [Meal]
    }
    
    @objc private func resetButtonTapped() {
        let alertController = UIAlertController(title: nil, message: "All stored meals are removed and sample meals will be loaded.", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Reset and Load Sample Meals", style: .destructive, handler: { (alertAction) in
            self.meals.removeAll()
            self.loadSampleMeals()
            self.tableView.reloadData()
            self.saveMeals()
        } ))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
