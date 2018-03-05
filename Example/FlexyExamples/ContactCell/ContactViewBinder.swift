//
//  UserCellViewBinder.swift
//  FlexyExamples
//
//  Created by Anisov Aleksey on 3/5/18.
//  Copyright © 2018 Flexy. All rights reserved.
//

import Flexy

class ContactViewBinder: ViewBinder {
    func bind(model: ContactItemModel, to cell: ContactTableViewCell) {
        cell.contactNameLabel.text = model.name
        cell.contactPhotoImageView.image = model.photo
    }
    
    var cellIdentifier: String {
        return "ContactCell"
    }
    
}
