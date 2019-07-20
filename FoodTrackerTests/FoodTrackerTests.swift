//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by 김성현 on 17/07/2019.
//  Copyright © 2019 Sunghyun Kim. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    //MARK: Meal Class Tests
    
    // Meal 이니셜라이저에게 유효한 매개변수가 전달되었을 때, Meal 객체를 반환하는지 확인합니다.
    func testMealInitializationSucceeds() {
        
        // 레이팅 점수 0
        let zeroRatingMeal = Meal(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        // 가장 높은 점수
        let positiveRatingMeal = Meal(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
        
    }
    
    // Meal 이니셜라이저에게 유효하지 않은 점수 또는 빈 이름을 전달하였을 때 nil을 반환하는지 확인합니다.
    func testMealInitializationFails() {
        
        // 음수 점수
        let negativeRatingMeal = Meal(name: "Negative", photo: nil, rating: -1)
        XCTAssertNil(negativeRatingMeal)
        
        // 빈 문자열
        let emptyStringMeal = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyStringMeal)
        
        // 점수 범위 초과
        let largeRatingMeal = Meal(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
        
    }

}
