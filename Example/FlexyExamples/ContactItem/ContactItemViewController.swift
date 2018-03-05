//
//  ContactItemViewController.swift
//  FlexyExamples
//
//  Created by Anisov Aleksey on 3/5/18.
//  Copyright © 2018 Flexy. All rights reserved.
//

import UIKit

class ContactItemViewController: UIViewController {
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var avatarImage: UIImage? {
        didSet {
            avatarImageView.image = avatarImage
        }
    }
}
