//
//  ContactTableViewCell.swift
//  FlexyExamples
//
//  Created by Anisov Aleksey on 3/5/18.
//  Copyright © 2018 Flexy. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet var contactPhotoImageView: UIImageView!
    @IBOutlet var contactNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contactPhotoImageView.layer.cornerRadius = 30
        contactPhotoImageView.layer.masksToBounds = true
    }
}
