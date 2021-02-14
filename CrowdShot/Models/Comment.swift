//
//  Comment.swift
//  CrowdShot
//
//  Created by Soni A on 13/02/2021.
//

import Foundation

struct Comment: Codable, Hashable, Equatable {
   let id:Int
   let userId:Int
   let userName:String
   let userProfileImage:String
   let videoId:Int
   let commentText:String
   let timeAgo:String
   let enable:Bool
}
