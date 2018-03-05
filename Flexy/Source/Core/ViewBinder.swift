//
//  ViewBinder.swift
//  Flexy
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

public protocol ViewBinder {
    associatedtype Model: ItemModel
    associatedtype Cell: Flexy.View
    
    func bind(model: Model, to cell: Cell)
    
    func onItemSelect(item: Model)
    
    var modelType: String { get }
    
    var cellIdentifier: String { get }
    
    var shouldRegisterCells: Bool { get }
}

extension ViewBinder {
    public func onItemSelect(item: Model) {
        // no-op
    }
    
    public var modelType: String {
        return Model.itemId
    }
    
    public var cellIdentifier: String {
        return String(describing: Cell.self)
    }
    
    public var shouldRegisterCells: Bool {
        return false
    }
}
