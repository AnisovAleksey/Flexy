//
//  _ViewBinder.swift
//  Flexy
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//


protocol _ViewBinder {
    func tryToBind<CellType: Flexy.View>(model: ItemModel, to view: CellType) -> CellType
    
    func handleClick(onItem item: ItemModel)
    
    var cellIdentifier: String { get }
    
    var cellType: AnyClass { get }
}

final class ViewBinderWrapper<Binder: ViewBinder>: _ViewBinder {
    private let viewBinder: Binder
    
    init(viewBinder: Binder) {
        self.viewBinder = viewBinder
    }
    
    func tryToBind<CellType: Flexy.View>(model: ItemModel, to view: CellType) -> CellType {
        guard let castedModel: Binder.Model = model as? Binder.Model else {
            fatalError("Incorrect model type in ViewBinder: \(type(of: self))")
        }
        
        guard let castedCell: Binder.Cell = view as? Binder.Cell else {
            fatalError("Incorrect cell type in ViewBinder: \(type(of: self))")
        }
        
        viewBinder.bind(model: castedModel, to: castedCell)
        
        return view
    }
    
    func handleClick(onItem item: ItemModel) {
        guard let castedItem = item as? Binder.Model else { return }
        viewBinder.onItemSelect(item: castedItem)
    }
    
    var cellIdentifier: String {
        return viewBinder.cellIdentifier
    }
    
    var cellType: AnyClass {
        return Binder.Cell.self
    }
}
