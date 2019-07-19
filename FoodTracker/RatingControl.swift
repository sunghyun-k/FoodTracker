import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("버튼: \(button)은(는) 배열: \(ratingButtons)에 존재하지 않습니다.")
        }
        
        // 선택된 버튼의 레이팅을 계산합니다.
        let selectedRating = index + 1
        
        if selectedRating == rating {
            // 선택된 별점이 현재 레이팅과 같다면, 레이팅을 0으로 초기화합니다.
            rating = 0
        } else {
            // 아니라면 선택된 별점으로 레이팅을 설정합니다.
            rating = selectedRating
        }
    }
    
    //MARK: Private Methods
    
    private func setupButtons() {
        
        // 기존의 버튼들을 정리합니다.
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // 버튼 이미지를 로드합니다.
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        
        for index in 0..<starCount {
            // 버튼을 생성합니다.
            let button = UIButton()
            
            // 버튼 이미지를 설정합니다.
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // 제약 사항을 추가합니다.
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // 손쉬운 사용 레이블을 추가합니다.
            button.accessibilityLabel = "별 \(index + 1)개 설정"
            
            // 버튼 액션을 설정합니다.
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // 버튼을 스택에 추가합니다.
            addArrangedSubview(button)
            
            // 새로운 버튼을 레이팅 버튼 배열에 추가합니다.
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            // 만약 버튼의 인덱스가 레이팅보다 작다면, 버튼은 선택 상태로 변경되어야 합니다.
            button.isSelected = index < rating
            
            // 현재 선택된 별점에 대한 힌트 문자열을 설정합니다.
            let hintString: String?
            if rating == index + 1 {
                hintString = "별점을 0으로 초기화하려면 탭하세요."
            } else {
                hintString = nil
            }
            
            // 값 문자열을 계산합니다.
            let valueString: String
            switch rating {
            case 0:
                valueString = "별점이 설정되지 않았습니다."
            case 1:
                valueString = "1점이 설정되었습니다."
            default:
                valueString = "\(rating)점이 설정되었습니다."
            }
            
            // 힌트 문자열과 값 문자열을 할당합니다.
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
