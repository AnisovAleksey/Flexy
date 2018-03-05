//
//  TableView+CellProvider.swift
//  Flexy
//
//  Created by Anisov Aleksey on 3/5/18.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

import UIKit

extension UITableView: CellProvider {
    public func reuseCell(for index: Flexy.Index, with type: String) -> Flexy.View {
        return dequeueReusableCell(withIdentifier: type, for: IndexPath(row: index.item, section: index.section))
    }
    
    public func register(type: AnyClass, forId id: String) {
        register(type, forCellReuseIdentifier: id)
    }
}
