
//
//  UserController.swift
//  CrowdShot
//
//  Created by Soni A on 22/11/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//
import UIKit

class UserController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.title = "User"
        tabBarItem.image = UIImage(named: "tabicon-user")
        view.backgroundColor = .yellow
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
