//
//  ItemModelTest.swift
//  FlexyTests
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

import XCTest
@testable import Flexy

class ItemModelTest: XCTestCase {
    
    func test_staticItemIdIsEqualToProperty() {
        // Given
        let testModel = TestItemModel(param: 0)
        
        // When
        
        
        // Then
        XCTAssertEqual(testModel.itemId, TestItemModel.itemId)
    }
    
}


private struct TestItemModel: ItemModel {
    let param: Int
}
