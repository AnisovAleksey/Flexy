//
//  _ViewBinder.swift
//  Flexy
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

import UIKit

protocol _ViewBinder {
    func tryToBind<CellType: UIView>(model: ItemModel, to view: CellType) throws -> CellType
    
    var cellIdentifier: String { get }
    
    var cellType: AnyClass { get }
}

final class ViewBinderWrapper<Binder: ViewBinder>: _ViewBinder {
    private let viewBinder: Binder
    
    init(viewBinder: Binder) {
        self.viewBinder = viewBinder
    }
    
    func tryToBind<CellType: UIView>(model: ItemModel, to view: CellType) throws -> CellType {
        guard let castedModel: Binder.Model = model as? Binder.Model else {
            throw ViewBinderError.incorrectModelType(type(of: self))
        }
        
        guard let castedCell: Binder.Cell = view as? Binder.Cell else {
            throw ViewBinderError.incorrectCellType(type(of: self))
        }
        
        viewBinder.bind(model: castedModel, to: castedCell)
        
        return view
    }
    
    var cellIdentifier: String {
        return viewBinder.cellIdentifier
    }
    
    var cellType: AnyClass {
        return Binder.Cell.self
    }
}

enum ViewBinderError: Error {
    case incorrectModelType(Any.Type)
    case incorrectCellType(Any.Type)
    
    var localizedDescription: String {
        switch self {
        case .incorrectCellType(let type):
            return "Incorrect cell type in ViewBinder: \(type)"
        case .incorrectModelType(let type):
            return "Incorrect model type in ViewBinder: \(type)"
        }
    }
}
