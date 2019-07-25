//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by 김성현 on 25/07/2019.
//  Copyright © 2019 Sunghyun Kim. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    //MARK: 프로퍼티
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
