//
//  SectionedTableController.swift
//  Flexy
//
//  Created by Aleksey Anisov on 19/09/2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

import UIKit

public class SectionedTableController: AbstractController<SectionedModelProvider>, UITableViewDelegate, UITableViewDataSource {
    private weak var tableView: UITableView?
    
    private var automaticallyDeselectCell: Bool = true
    
    public init(tableView: UITableView) {
        self.tableView = tableView
        super.init(modelProvider: SectionedModelProvider(sectionItemModels: []))
        
        self.cellProvider = tableView
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return reuseCell(for: Flexy.Index(section: indexPath.section, item: indexPath.row), from: tableView)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didClickOnItem(on: Flexy.Index(section: indexPath.section, item: indexPath.row))
        
        if automaticallyDeselectCell {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerModel = sections[section].headerModel else {
            return nil
        }
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: cellIdentifier(for: headerModel)) else {
            return nil
        }
        
        return bind(cell: headerView, with: headerModel)
    }
    
    public override func onItemsChange() {
        tableView?.reloadData()
    }
}
