//
//  AbstractController.swift
//  Flexy
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

import Foundation
import UIKit

open class AbstractController: NSObject {
    internal var viewBinders: [String: _ViewBinder] = [:]
    
    public var itemModels: [ItemModel] = []
    
    internal weak var cellProvider: CellProvider?
    
    final func _register<VB: ViewBinder>(binder: VB) throws {
        let key = binder.modelType
        let binderWrapper = ViewBinderWrapper(viewBinder: binder)
        
        guard viewBinders[key] == nil else {
            throw ViewBinderRegistrationError.viewBinderAlreadyExist(key)

        }
        guard let cellProvider = cellProvider else {
            throw ViewBinderRegistrationError.cellProviderNotAvailable
        }
        binderWrapper.registerType(to: cellProvider)
        viewBinders[key] = binderWrapper
    }
    
    public final func register<VB: ViewBinder>(binder: VB) {
        do {
            return try _register(binder: binder)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    public final func unregister<VB: ViewBinder>(binder: VB) {
        viewBinders.removeValue(forKey: binder.cellIdentifier)
    }
    
    public final func reuseCell<CellType: UIView>(for indexPath: IndexPath, from cellProvider: CellProvider) throws -> CellType {
        let model = itemModels[indexPath.row]
        
        guard let viewBinder = self.viewBinders[model.itemId] else {
            fatalError("Can't find ViewBinder for key '\(model.itemId)'")
        }
        
        guard let cell = cellProvider.reuseCell(for: indexPath, with: viewBinder.cellIdentifier) as? CellType else {
            fatalError("Can't reuse cell with passed CellType: \(CellType.self)")
        }
        
        do {
            return try viewBinder.tryToBind(model: model, to: cell)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
}

enum ViewBinderRegistrationError: Error {
    case viewBinderAlreadyExist(String)
    case cellProviderNotAvailable
    
    var localizedDescription: String {
        switch self {
        case .viewBinderAlreadyExist(let key):
            return "ViewBinder with key '\(key)' already registered."
        case .cellProviderNotAvailable:
            return "Cell provider isn't available in Controller. It was released or never setuped."
        }
    }
}
