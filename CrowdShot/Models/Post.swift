//
//  Post.swift
//  CrowdShot
//
//  Created by Soni A on 13/02/2021.
//

import Foundation

struct Post: Codable, Hashable, Equatable {
    let id: Int
    let title: String
    let userName: String
    let coverImage: String
    let videoUrl:String
}
