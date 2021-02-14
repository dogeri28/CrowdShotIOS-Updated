//
//  BaseTabBarController.swift
//  CrowdShot
//
//  Created by Soni A on 22/11/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//
import UIKit
import Combine

class BaseTabBarController: UITabBarController {
    var storage = Set<AnyCancellable>()
    var currentScreen = 0
    var userId = 0
    var commentId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
        print("value of the screen \(currentScreen) the user id sent is \(userId)  and the comment id is \(commentId)")
    }
    
    private func configureTabs() {
        tabBar.barTintColor = UIColor(red:0.13, green:0.12, blue:0.12, alpha:1.00)
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .white

        let homeController = HomeController()
        homeController.tabBarItem.image = UIImage(named: "tabicon-home")
        homeController.tabBarItem.title = "Home"
        
        let discoverController = DiscoverController()
        discoverController.tabBarItem.image = UIImage(named: "tabicon-search")
        discoverController.tabBarItem.title = "Discover"
        
        let recordController = ViewController()
        recordController.tabBarItem.title = "Record"
        recordController.tabBarItem.image = UIImage(named: "tabicon-record")!.withRenderingMode(.alwaysOriginal);
        recordController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: 8, right: 0)
        
        
        let userController = UserController()
        userController.tabBarItem.image =  UIImage(named: "tabicon-user")
        userController.tabBarItem.title = "User"
        
        let inboxController = InboxController()
        inboxController.tabBarItem.image =  UIImage(named: "tabicon-inbox")
        inboxController.tabBarItem.title = "Inbox"

        viewControllers = [
         homeController,
         discoverController,
         recordController,
         inboxController,
         userController
        ]
        
//        let vm = TestViewModel(client: CrowdShotAPI())
//        vm.postComment();
//        vm.$comment.sink { _ in
//
//        } receiveValue: { (comment) in
//            if let c = comment {
//                let response:Comment  = c
//                print(response)
//            }
//        }.store(in: &storage)
    }
}
