//
//  Article.swift
//  CrowdShot
//
//  Created by Soni A on 13/02/2021.
//
import Foundation

struct Article: Codable, Hashable, Equatable {
    let id: Int
    let title: String
    let description: String
    let coverImage: String
    let mediaUrl:String
    let link:String
    let artWorkUrl: URL
}
