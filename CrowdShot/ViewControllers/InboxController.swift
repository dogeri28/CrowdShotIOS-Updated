//
//  InboxController.swift
//  CrowdShot
//
//  Created by Soni A on 22/11/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//
import UIKit

class InboxController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.title = "Inbox"
        tabBarItem.image = #imageLiteral(resourceName: "tabicon-inbox")
        view.backgroundColor = .green
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
