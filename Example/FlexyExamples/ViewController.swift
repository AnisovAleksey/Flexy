//
//  ViewController.swift
//  FlexyExamples
//
//  Created by Anisov Aleksey on 3/5/18.
//  Copyright © 2018 Flexy. All rights reserved.
//

import UIKit
import Flexy

class ViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    private lazy var tableController: SimpleTableController = SimpleTableController(tableView: tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableController.register(binder: ContactViewBinder())
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableController.itemModels = [
            ContactItemModel(photo: UIImage(named: "avatar1")!, name: "Marie"),
            ContactItemModel(photo: UIImage(named: "avatar3")!, name: "Benjamin"),
            ContactItemModel(photo: UIImage(named: "avatar1")!, name: "Sofia"),
            ContactItemModel(photo: UIImage(named: "avatar2")!, name: "Barry"),
            ContactItemModel(photo: UIImage(named: "avatar1")!, name: "Elizabeth"),
            ContactItemModel(photo: UIImage(named: "avatar1")!, name: "Chloe"),
            ContactItemModel(photo: UIImage(named: "avatar3")!, name: "Brian"),
            ContactItemModel(photo: UIImage(named: "avatar2")!, name: "Corwin"),
            ContactItemModel(photo: UIImage(named: "avatar3")!, name: "Christopher"),
        ]
    }
}

