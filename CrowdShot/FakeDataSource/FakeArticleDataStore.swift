//
//  FakeArticleDataStore.swift
//  CrowdShot
//
//  Created by Soni A on 26/12/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//

import Foundation

struct FakeArticleDataStore {
    func getArticles() -> [Article] {
        var articleCollection = [Article]()
        let url = URL(fileURLWithPath: "")
       
        let article1 = Article.init(id: 1, title: "august alsina: will smith gave me permission to sleep w/wife jada pinkett smith!!", description: "", coverImage: "articleimage1", mediaUrl: "", link: "", artWorkUrl: url)
        
        let article2 = Article.init(id: 2, title: "I am the GOAT and I dont care what anyone says...", description: "", coverImage: "articleimage2", mediaUrl: "", link: "", artWorkUrl: url)
        
        let article3 = Article.init(id: 3, title: "What coud be going on in her mind, Usher is all out to watch the game...", description: "", coverImage: "articleimage3", mediaUrl: "", link: "", artWorkUrl: url)
        
        let article4 = Article.init(id: 4, title: "Revelation: For the first time ever, SlutWalk Festival LA founder Amber Rose revealed...", description: "", coverImage: "articleimage4", mediaUrl: "", link: "", artWorkUrl: url)
       
        let article5 = Article.init(id: 5, title: "Over the last 24 hours, Trump has called for a primary challenge to the second-ranking Senate Republican", description: "", coverImage: "articleimage5", mediaUrl: "", link: "", artWorkUrl: url)
        
        let article6 = Article.init(id: 6, title: "There has long been a jarring divide in Rock’s work between his comedy and his film career", description: "", coverImage: "articleimage6", mediaUrl: "", link: "", artWorkUrl: url)
        
        articleCollection.append(article1)
        articleCollection.append(article2)
        articleCollection.append(article3)
        articleCollection.append(article4)
        articleCollection.append(article5)
        articleCollection.append(article6)
    
        return articleCollection
    }
}
