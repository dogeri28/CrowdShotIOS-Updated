//
//  AppDelegate.swift
//  CrowdShot
//
//  Created by Soni A on 22/11/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//

import UIKit
import OneSignal
import BanubaSdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
 
    var window: UIWindow?

    static let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let statusBarBackgroundView = UIView()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        //window?.rootViewController = BaseTabBarController()
        //window?.makeKeyAndVisible()
        setupBanuba()
        setupStatusBar()
        setupPushNotifications(launchOptions: launchOptions)
        return true
    }
 

    private func setupPushNotifications(launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) {
        
//        START OneSignal initialization code
       // let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        let notificationOpenedBlock:  OSNotificationOpenedBlock  = {  result in
               // This block gets called when the user reacts to a notification received
               let payload = result.notification
               var fullMessage = payload.body
                print("Message = \(fullMessage ?? "message")")

               if payload.additionalData != nil {
                  let additionalData = payload.additionalData
                  if additionalData?["actionSelected"] != nil {
                    fullMessage = fullMessage! + "\nPressed ButtonID: \(additionalData!["actionSelected"] ?? "action selected")"
                  }

                 //test additional data with push notification
                let userId = additionalData?["userId"]
                let commentId = additionalData?["commentId"]
                let hiddenData = "We have userId \(String(describing: userId ?? "NO USERID")) with comment id of  \(String(describing: commentId ?? "NO COMMENTID"))"
                print(hiddenData)

            if let viewController = self.window?.rootViewController! {
                if viewController is BaseTabBarController {
                    let tabController = viewController as! BaseTabBarController
                        tabController.currentScreen = 1
                        tabController.selectedIndex = 1
                     }
                }
            }
        }

        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        // OneSignal.initWithLaunchOptions(launchOptions,
        //                                 appId: "a3b05f00-7a69-45a1-9c90-f9d5e89bb5cd",
        //                                 handleNotificationAction: notificationOpenedBlock,
        //                                 settings: nil)

        
        OneSignal.setNotificationOpenedHandler(notificationOpenedBlock)
        OneSignal.setAppId("a3b05f00-7a69-45a1-9c90-f9d5e89bb5cd")
            
        //OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;

        // TODO: Remove this as we do not want to request / prompt for push notification
        //       on load of the app...
        OneSignal.promptForPushNotifications { (accepted) in
            print("User accepted notifications: \(accepted)")
        }
    }

    fileprivate func setupStatusBar()  {
        statusBarBackgroundView.backgroundColor = .black
        window?.addSubview(statusBarBackgroundView)

        var height:CGFloat = 0
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            height = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            height = UIApplication.shared.statusBarFrame.height
        }

        window?.addConstraintsWithFormat("H:|[v0]|", views: statusBarBackgroundView)
        window?.addConstraintsWithFormat("V:|[v0(\(height))]", views: statusBarBackgroundView)
    }
    
    //MARK: Sets up license for Banuba SDK
    func setupBanuba()
    {
        
//        let deviceDocumentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.path
//        BanubaSdkManager.initialize(
//            resourcePath: [Bundle.main.bundlePath + "/effects", deviceDocumentsPath! + "/Effects/"],
//            clientTokenString: banubaClientToken)
        
        
        
        BanubaSdkManager.initialize(
            resourcePath: [Bundle.main.bundlePath + "/effects", AppDelegate.documentsPath + "/effects"],
            clientTokenString: banubaClientToken
        )
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...)  {
        var viewsDictionary = [String : UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

enum ViewTag: Int {
    case statusBarBackgroundView = 1001
}
