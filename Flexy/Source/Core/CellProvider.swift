//
//  CellProvider.swift
//  Flexy
//
//  Created by Aleksey Anisov on 03.03.2018.
//  Copyright © 2018 Aleksey Anisov. All rights reserved.
//

import UIKit

public protocol CellProvider: class {
    func reuseCell(for indexPath: IndexPath, with type: String) -> UIView
    
    func register(type: AnyClass, forId id: String)
    
    func unregister(id: String)
}
