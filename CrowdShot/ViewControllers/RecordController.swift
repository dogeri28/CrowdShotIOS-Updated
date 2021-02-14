//
//  RecordController.swift
//  CrowdShot
//
//  Created by Soni A on 22/11/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//

import UIKit

class RecordController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.title = "Record"
        view.backgroundColor = .red
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
