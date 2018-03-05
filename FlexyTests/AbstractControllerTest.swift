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
    private let controller = AbstractController()
    private let cellProvider = TestCellProvider()
    
    override func setUp() {
        super.setUp()
        
        controller.cellProvider = cellProvider
    }
    
    func test_successBinderRegistration() {
        // Given
        let binder = TestViewBinder()
        
        // When
        try! controller._register(binder: binder)
        
        // Then
        XCTAssertTrue(cellProvider.registered!.0 == UITableViewCell.self)
        XCTAssertTrue(controller.viewBinders.contains(where: { $0.key == binder.modelType }))
    }
    
    func test_registerTheSameViewBinder() {
        // Given
        let binder = TestViewBinder()
        let binder2 = TestViewBinder()
        try! controller._register(binder: binder)
        
        // When
        do {
            try controller._register(binder: binder2)
        } catch let error {
         
        // Then
            guard let registrationError = error as? ViewBinderRegistrationError,
                case .viewBinderAlreadyExist( _) = registrationError else {
                    XCTFail()
                    return
            }
        }
    }
    
    func test_registerViewBinderWithNilCellProvider() {
        // Given
        let binder = TestViewBinder()
        controller.cellProvider = TestCellProvider()
        
        // When
        do {
            try controller._register(binder: binder)
        } catch let error {
        
        // Then
            guard let registrationError = error as? ViewBinderRegistrationError,
                case .cellProviderNotAvailable = registrationError else {
                    XCTFail()
                    return
            }
        }
    }
    
    func test_successRegistrationBinderWithCustomCellId() {
        // Given
        let binder = IdentifiedViewBinder()
        
        // When
        try! controller._register(binder: binder)
        
        // Then
        XCTAssertTrue(cellProvider.registered!.0 == UITableViewCell.self)
        XCTAssertTrue(cellProvider.registered!.1 == "ID")
        XCTAssertTrue(controller.viewBinders.contains(where: { $0.key == binder.modelType }))
    }
    
    func test_unregisterBinder() {
        // Given
        let binder = TestViewBinder()
        
        // When
        try! controller._register(binder: binder)
        controller.unregister(binder: binder)
        
        // Then
        XCTAssertTrue(cellProvider.registered!.1 == "UITableViewCell")
        XCTAssertTrue(cellProvider.unregistered! == "UITableViewCell")
        XCTAssertFalse(controller.viewBinders.contains(where: { $0.key == binder.modelType }))
    }
}


private class TestViewBinder: ViewBinder {
    
    var binded: Bool = false
    
    func bind(model: TestItemModel, to cell: UITableViewCell) {
        binded = true
    }
}

private struct TestItemModel: ItemModel {
    
}

private class TestCellProvider: CellProvider {
    var registered: (AnyClass, String)?
    var unregistered: (String)?
    
    func register(type: AnyClass, forId id: String) {
        registered = (type, id)
    }
    
    func unregister(id: String) {
        unregistered = id
    }
    
    func reuseCell(for indexPath: IndexPath, with type: String) -> UIView {
        return UIView()
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
