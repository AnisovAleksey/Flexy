//
//  PlainModelProvider.swift
//  Flexy
//
//  Created by Aleksey Anisov on 19/09/2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//


public struct PlainModelProvider: ItemModelProvider {
    public let itemModels: [ItemModel]
    
    public init(itemModels: [ItemModel]) {
        self.itemModels = itemModels
    }
    
    public subscript(index: Flexy.Index) -> ItemModel {
        return itemModels[index.item]
    }
}
