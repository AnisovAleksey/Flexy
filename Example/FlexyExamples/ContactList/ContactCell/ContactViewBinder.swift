//
//  UserCellViewBinder.swift
//  FlexyExamples
//
//  Created by Anisov Aleksey on 3/5/18.
//  Copyright © 2018 Flexy. All rights reserved.
//

import Flexy

class ContactViewBinder: ViewBinder {
    private let clickHandler: ((ContactItemModel) -> ())?
    
    init(_ handler: ((ContactItemModel) -> ())? = nil) {
        clickHandler = handler
    }
    
    func bind(model: ContactItemModel, to cell: ContactTableViewCell) {
        cell.contactNameLabel.text = model.name
        cell.contactPhotoImageView.image = model.photo
    }
    
    func onItemSelect(item: ContactItemModel) {
        clickHandler?(item)
    }
    
    var cellIdentifier: String {
        return "ContactCell"
    }
    
}
