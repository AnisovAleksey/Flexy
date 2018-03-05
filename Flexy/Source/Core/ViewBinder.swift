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
    
    var modelType: String { get }
    
    var cellIdentifier: String { get }
}

extension ViewBinder {
    var modelType: String {
        return Model.itemId
    }
    
    var cellIdentifier: String {
        return String(describing: Cell.self)
    }
}
