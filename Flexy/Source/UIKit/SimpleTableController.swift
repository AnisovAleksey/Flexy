//
//  SimpleTableController.swift
//  Flexy
//
//  Created by Anisov Aleksey on 3/5/18.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

import UIKit

public class SimpleTableController: AbstractController, UITableViewDelegate, UITableViewDataSource {
    private weak var tableView: UITableView?
    public weak var tableViewDelegate: UITableViewDelegate?
    
    public override var itemModels: [ItemModel] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    public init(tableView: UITableView) {
        super.init()
        
        self.tableView = tableView
        self.cellProvider = tableView
        
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return reuseCell(for: Flexy.Index(section: indexPath.section, item: indexPath.row), from: tableView)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didClickOnItem(on: Flexy.Index(section: indexPath.section, item: indexPath.row))
        
        tableViewDelegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    public override func responds(to selector: Selector!) -> Bool {
        let haveSelector = super.responds(to: selector)
        
        if !haveSelector,
            let delegate = tableViewDelegate {
            return delegate.responds(to: selector)
        }
        return haveSelector
    }
}
