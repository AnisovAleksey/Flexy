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
        _ = try! wrapper.tryToBind(model: itemModel, to: cell)
        
        // Then
        XCTAssertTrue(viewBinder.binded)
    }
    
    func test_bindIncorrectModelToCorrectCell() {
        // Given
        let itemModel = IncorrectItemModel(param: 0)
        let cell = UITableViewCell()
        
        // When
        do {
            _ = try wrapper.tryToBind(model: itemModel, to: cell)
        } catch let error {
        
       // Then
            guard let binderError = error as? ViewBinderError,
                case .incorrectModelType( _) = binderError else {
                    XCTFail()
                    return
            }
        }
    }
    
    func test_bindCorrectModelToIncorrectCell() {
        // Given
        let itemModel = TestItemModel(param: 0)
        let cell = UICollectionViewCell()
        
        // When
        do {
            _ = try wrapper.tryToBind(model: itemModel, to: cell)
        } catch let error {
            
        // Then
            guard let binderError = error as? ViewBinderError,
                case .incorrectCellType( _) = binderError else {
                    XCTFail()
                    return
            }
        }
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

private struct IncorrectItemModel: ItemModel {
    let param: Int
}

private class TestCellProvider: CellProvider {
    var registered: (AnyClass, String)?
    
    func register(type: AnyClass, forId id: String) {
        registered = (type, id)
    }
    
    func unregister(id: String) {
        
    }

    func reuseCell(for index: Flexy.Index, with type: String) -> Flexy.View {
        return Flexy.View()
    }
}
