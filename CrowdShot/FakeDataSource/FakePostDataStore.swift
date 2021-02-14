//
//  FakePostDataStore.swift
//  CrowdShot
//
//  Created by Soni A on 26/12/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//

import Foundation

struct FakePostDataStore {
    
    func getPosts() -> [Post] {
        var postCollection = [Post]()
        
        let post1 = Post.init(id: 1, title: "Shocked! Never new", userName: "@tasha", coverImage: "postimage8", videoUrl: "postvideo-1")
        let post2 = Post.init(id: 2, title: "I knew this was fishy", userName: "@ceedavis", coverImage: "postimage7", videoUrl: "postvideo-2")
        let post3 = Post.init(id: 3, title: "My guess is", userName: "@tasha", coverImage: "postimage6", videoUrl: "postvideo-3")
        let post4 = Post.init(id: 4, title: "i love this article", userName: "@james", coverImage: "postimage5", videoUrl: "postvideo-4")
        let post5 = Post.init(id: 5, title: "Makes me laugh", userName: "@tracey", coverImage: "postimage4", videoUrl: "postvideo-5")
        let post6 = Post.init(id: 6, title: "Big mistake on her part", userName: "@mike", coverImage: "postimage3", videoUrl: "postvideo-6")
        let post7 = Post.init(id: 7, title: "This is why i love hollywood", userName: "@jaytee", coverImage: "postimage2", videoUrl: "postvideo-7")
        let post8 = Post.init(id: 8, title: "Big dreams", userName: "@dan", coverImage: "postimage1", videoUrl: "postvideo-1")
        
        let post9 = Post.init(id: 9, title: "Shocked! Never new", userName: "@tasha", coverImage: "postimage8", videoUrl: "postvideo-1")
        let post10 = Post.init(id: 10, title: "I knew this was fishy", userName: "@ceedavis", coverImage: "postimage7", videoUrl: "postvideo-2")
        let post11 = Post.init(id: 11, title: "My guess is", userName: "@tasha", coverImage: "postimage6", videoUrl: "postvideo-2")
        let post12 = Post.init(id: 12, title: "i love this article", userName: "@james", coverImage: "postimage5", videoUrl: "postvideo-3")
        let post13 = Post.init(id: 13, title: "i love this article", userName: "@james", coverImage: "postimage5", videoUrl: "postvideo-4")
        let post14 = Post.init(id: 14, title: "i love this article", userName: "@james", coverImage: "postimage5", videoUrl: "postvideo-5")
        let post15 = Post.init(id: 15, title: "i love this article", userName: "@james", coverImage: "postimage5", videoUrl: "postvideo-6")
        let post16 = Post.init(id: 16, title: "i love this article", userName: "@james", coverImage: "postimage5", videoUrl: "postvideo-7")
        let post17 = Post.init(id: 17, title: "i love this article", userName: "@james", coverImage: "postimage5", videoUrl: "postvideo-1")
        let post18 = Post.init(id: 18, title: "i love this article", userName: "@james", coverImage: "postimage5", videoUrl: "postvideo-2")
        let post19 = Post.init(id: 19, title: "i love this article", userName: "@james", coverImage: "postimage5", videoUrl: "postvideo-3")
        let post20 = Post.init(id: 20, title: "i love this article", userName: "@james", coverImage: "postimage5", videoUrl: "postvideo-4")
//        let post21 = Post.init(id: 21, title: "Shocked! Never new", userName: "@tasha", coverImage: "postimage8", videoUrl: "postvideo-0")
        
   
        postCollection.append(post1)
        postCollection.append(post2)
        postCollection.append(post3)
        postCollection.append(post4)
        postCollection.append(post5)
        postCollection.append(post6)
        postCollection.append(post7)
        postCollection.append(post8)
        postCollection.append(post9)
        postCollection.append(post10)
        postCollection.append(post11)
        postCollection.append(post12)
        postCollection.append(post13)
        postCollection.append(post14)
        postCollection.append(post15)
        postCollection.append(post16)
        postCollection.append(post17)
        postCollection.append(post18)
        postCollection.append(post19)
        postCollection.append(post20)
//        postCollection.append(post21)
 
        return postCollection
    }
}
