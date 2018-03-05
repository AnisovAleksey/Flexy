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
    
    func test_registerCellToCellProvider() {
        // Given
        let cellProvider = TestCellProvider()
        
        // When
        wrapper.registerType(to: cellProvider)

        // Then
        XCTAssertTrue(cellProvider.registered!.0 == UITableViewCell.self)
        XCTAssertEqual(cellProvider.registered!.1, "UITableViewCell")
    }
    
    func test_registerCellToCellProviderWithCustomIdentifier() {
        // Given
        let cellProvider = TestCellProvider()
        let wrapper = ViewBinderWrapper(viewBinder: IdentifiedViewBinder())
        
        // When
        wrapper.registerType(to: cellProvider)
        
        // Then
        XCTAssertTrue(cellProvider.registered!.0 == UITableViewCell.self)
        XCTAssertEqual(cellProvider.registered!.1, "ID")
    }
}


private class TestViewBinder: ViewBinder {
    var binded: Bool = false
    
    func bind(model: TestItemModel, to cell: UITableViewCell) {
        binded = true
    }
}

private class IdentifiedViewBinder: ViewBinder {
    func bind(model: TestItemModel, to cell: UITableViewCell) {
        // no-op
    }
    
    var cellIdentifier: String {
        return "ID"
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
    
    func reuseCell(for indexPath: IndexPath, with type: String) -> UIView {
        return UIView()
    }
}
