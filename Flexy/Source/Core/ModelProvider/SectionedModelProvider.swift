//
//  SectionedModelProvider.swift
//  Flexy
//
//  Created by Aleksey Anisov on 19/09/2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

public struct SectionedModelProvider: ItemModelProvider {
    public let sectionItemModels: [SectionItemModel]
    
    public init(sectionItemModels: [SectionItemModel]) {
        self.sectionItemModels = sectionItemModels
    }
    
    public subscript(index: Flexy.Index) -> ItemModel {
        return sectionItemModels[index.section].items[index.item]
    }
}
