//
//  SimpleTableController.swift
//  Flexy
//
//  Created by Anisov Aleksey on 3/5/18.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

import UIKit

public class SimpleTableController: AbstractController<PlainModelProvider>, UITableViewDelegate, UITableViewDataSource {
    private let selectionHandler: ((IndexPath) -> ())?
    
    private var automaticallyDeselectCell: Bool = true
    
    private weak var tableView: UITableView?
    
    public init(tableView: UITableView, selectionHandler: ((IndexPath) -> ())? = nil) {
        self.selectionHandler = selectionHandler
        super.init(modelProvider: PlainModelProvider(itemModels: []))
        
        self.tableView = tableView
        self.cellProvider = tableView
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return reuseCell(for: Flexy.Index(section: indexPath.section, item: indexPath.row), from: tableView)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didClickOnItem(on: Flexy.Index(section: indexPath.section, item: indexPath.row))
        
        if automaticallyDeselectCell {
            tableView.deselectRow(at: indexPath, animated: false)
        }
        selectionHandler?(indexPath)
    }
    
    public override func onItemsChange() {
        tableView?.reloadData()
    }
}
