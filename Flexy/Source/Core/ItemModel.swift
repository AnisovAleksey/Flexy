//
//  ItemModel.swift
//  Flexy
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

public protocol ItemModel {
    static var itemId: String { get }
    
    var itemId: String { get }
}

extension ItemModel {
    static var itemId: String {
        return String(describing: self)
    }
    
    var itemId: String {
        return type(of: self).itemId
    }
}
