//
//  ViewBinderTest.swift
//  FlexyTests
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

import XCTest
import UIKit
@testable import Flexy

class ViewBinderWrapperTest: XCTestCase {
    private var viewBinder: TestViewBinder!
    private var wrapper: ViewBinderWrapper<TestViewBinder>!
    
    
    override func setUp() {
        super.setUp()
        
        viewBinder = TestViewBinder()
        wrapper = ViewBinderWrapper(viewBinder: viewBinder)
    }
    
    func test_bindCorrectModelToCorrectCell() {
        // Given
        let itemModel = TestItemModel(param: 0)
        let cell = UITableViewCell()
        
        // When
        _ = wrapper.tryToBind(model: itemModel, to: cell)
        
        // Then
        XCTAssertTrue(viewBinder.binded)
    }
}


private class TestViewBinder: ViewBinder {
    var binded: Bool = false
    
    func bind(model: TestItemModel, to cell: UITableViewCell) {
        binded = true
    }
}

private struct TestItemModel: ItemModel {
    let param: Int
}
