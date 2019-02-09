//
//  AbstractControllerTest.swift
//  FlexyTests
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

import XCTest
@testable import Flexy

class AbstractControllerTest: XCTestCase {
    private let controller = AbstractController(modelProvider: PlainModelProvider(itemModels: []))
    private let cellProvider = TestCellProvider()
    
    override func setUp() {
        super.setUp()
        
        controller.cellProvider = cellProvider
    }
    
    func test_successBinderRegistrationWithCellRegistration() {
        // Given
        let binder = TestViewBinder(shouldRegisterCells: true)
        
        // When
        controller.register(binder: binder)
        
        // Then
        XCTAssertTrue(cellProvider.registered!.0 == UITableViewCell.self)
        XCTAssertTrue(controller.viewBinders.contains(where: { $0.key == binder.modelType }))
    }
    
    func test_successBinderRegistrationWithoutCellRegistration() {
        // Given
        let binder = TestViewBinder()
        
        // When
        controller.register(binder: binder)
        
        // Then
        XCTAssertTrue(cellProvider.registered == nil)
        XCTAssertTrue(controller.viewBinders.contains(where: { $0.key == binder.modelType }))
    }
    
    func test_successRegistrationBinderWithCustomCellId() {
        // Given
        let binder = IdentifiedViewBinder()
        
        // When
        controller.register(binder: binder)
        
        // Then
        XCTAssertTrue(cellProvider.registered!.0 == UITableViewCell.self)
        XCTAssertTrue(cellProvider.registered!.1 == "ID")
        XCTAssertTrue(controller.viewBinders.contains(where: { $0.key == binder.modelType }))
    }
}


private class TestViewBinder: ViewBinder {
    let shouldRegisterCells: Bool
    var binded: Bool = false
    
    init(shouldRegisterCells: Bool = false) {
        self.shouldRegisterCells = shouldRegisterCells
    }
    
    func bind(model: TestItemModel, to cell: UITableViewCell) {
        binded = true
    }
}

private struct TestItemModel: ItemModel {
    
}

private class TestCellProvider: CellProvider {
    var registered: (AnyClass, String)?
    
    func register(type: AnyClass, forId id: String) {
        registered = (type, id)
    }
    
    func reuseCell(for index: Flexy.Index, with type: String) -> Flexy.View {
        return Flexy.View()
    }
}



private class IdentifiedViewBinder: ViewBinder {
    func bind(model: TestItemModel, to cell: UITableViewCell) {
        // no-op
    }
    
    var cellIdentifier: String {
        return "ID"
    }
    
    var shouldRegisterCells: Bool {
        return true
    }
}
