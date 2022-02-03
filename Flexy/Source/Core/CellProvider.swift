//
//  CellProvider.swift
//  Flexy
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

public protocol CellProvider: AnyObject {
    func reuseCell(for index: Flexy.Index, with type: String) -> Flexy.View
    
    func register(type: AnyClass, forId id: String)
}
