//
//  ItemModelProvider.swift
//  Flexy
//
//  Created by Aleksey Anisov on 19/09/2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

public protocol ItemModelProvider {
    subscript(index: Flexy.Index) -> ItemModel { get }
}
