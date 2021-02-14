//
//  User.swift
//  CrowdShot
//
//  Created by Soni A on 13/02/2021.
//

import Foundation

struct User: Codable, Hashable, Equatable {
   let loginId:String
   let name:String
   let profileImageUrl: String
   let enable:Bool
   let notificationId:String
}
