import UIKit
import os.log

class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("meals")
    
    //MARK: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
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
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // 이름은 필수적입니다. 만약 이름 문자열을 디코드하지 못한다면 이니셜라이저가 실패해야 합니다.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Meal 오브젝트를 디코드할 수 없습니다.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // 이미지는 선택적(옵셔널) 프로퍼티이므로 조건부 캐스트(conditional cast)만 사용하도록 합니다.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        // 반드시 지정 이니셜라이저(designated initializer)를 호출해야 합니다.
        self.init(name: name, photo: photo, rating: rating)
    }
}
