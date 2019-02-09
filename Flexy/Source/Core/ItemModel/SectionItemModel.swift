//
//  SectionItemModel.swift
//  Flexy
//
//  Created by Aleksey Anisov on 19/09/2018.
//

public protocol SectionItemModel {
    var headerModel: ItemModel? { get }
    
    var footerModel: ItemModel? { get }
    
    var items: [ItemModel] { get }
}

public extension SectionItemModel {
    var headerModel: ItemModel? {
        return nil
    }
    
    var footerModel: ItemModel? {
        return nil
    }
}
