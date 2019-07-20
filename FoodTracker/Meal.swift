import UIKit

class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // 이름은 비어있으면 안됩니다.
        guard !name.isEmpty else {
            return nil
        }
        
        // 점수는 0과 5 사이에 있어야 합니다.
        guard rating >= 0 && rating <= 5 else {
            return nil
        }
        
        // 저장 속성을 초기화합니다.
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
}
