//
//  AbstractController.swift
//  Flexy
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

import Foundation

open class AbstractController<ModelProvider: ItemModelProvider>: NSObject {
    internal var viewBinders: [String: _ViewBinder] = [:]
    
    public var modelProvider: ModelProvider {
        didSet { onItemsChange() }
    }
    
    public init(modelProvider: ModelProvider) {
        self.modelProvider = modelProvider
    }
    
    internal weak var cellProvider: CellProvider?
    
    public final func register<VB: ViewBinder>(binder: VB) {
        let key = binder.modelType
        let binderWrapper = ViewBinderWrapper(viewBinder: binder)
        
        guard viewBinders[key] == nil else {
            assertionFailure("ViewBinder with key '\(key)' already registered.")
            return
        }
        guard let cellProvider = cellProvider else {
            fatalError("Cell provider isn't available in Controller. It was released or never setuped.")
        }
        if binder.shouldRegisterCells {
            cellProvider.register(type: binderWrapper.cellType, forId: binderWrapper.cellIdentifier)
        }
        viewBinders[key] = binderWrapper
    }
    
    public final func reuseCell<CellType: Flexy.View>(for index: Flexy.Index, from cellProvider: CellProvider) -> CellType {
        let model = modelProvider[index]
        
        guard let cell = cellProvider.reuseCell(for: index, with: cellIdentifier(for: model)) as? CellType else {
            fatalError("Can't reuse cell with passed CellType: \(CellType.self)")
        }
        
        return bind(cell: cell, with: model)
    }
    
    public final func didClickOnItem(on index: Flexy.Index) {
        let model = modelProvider[index]
    
        viewBinder(for: model).handleClick(onItem: model)
    }
    
    public final func cellIdentifier(for model: ItemModel) -> String {
        return viewBinder(for: model).cellIdentifier
    }
    
    public final func bind<CellType: Flexy.View>(cell: CellType, with model: ItemModel) -> CellType {
        do {
            return try viewBinder(for: model).tryToBind(model: model, to: cell)
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    open func onItemsChange() {
        // for override
    }
    
    private func viewBinder(for model: ItemModel) -> _ViewBinder {
        guard let viewBinder = self.viewBinders[model.itemId] else {
            fatalError("Can't find ViewBinder for key '\(model.itemId)'")
        }
        return viewBinder
    }
}

public extension AbstractController where ModelProvider == PlainModelProvider {
    var items: [ItemModel] {
        get {
            return modelProvider.itemModels
        }
        set {
            modelProvider = PlainModelProvider(itemModels: newValue)
        }
    }
}

public extension AbstractController where ModelProvider == SectionedModelProvider {
    var sections: [SectionItemModel] {
        get {
            return modelProvider.sectionItemModels
        }
        set {
            modelProvider = SectionedModelProvider(sectionItemModels: newValue)
        }
    }
}
