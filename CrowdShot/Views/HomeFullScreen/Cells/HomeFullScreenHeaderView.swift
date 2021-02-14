//
//  HomeFullScreenHeaderView.swift
//  CrowdShot
//
//  Created by Soni A on 02/01/2021.
//  Copyright © 2021 Thoughtlights. All rights reserved.
//

import Foundation
import UIKit
import Combine

class HomeFullScreenHeaderView: UICollectionReusableView , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    static let reuseIdentifier = "home-full-section-header-view"
    let articleDataSource = FakeArticleDataStore()
    enum Section: Int {
        case Article = 1
    }
    
    lazy var articleCollectionView : UICollectionView = {
         var layout = SnappingFlowLayout()
         layout.scrollDirection = .horizontal
         let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
         collectionView.backgroundColor = .black
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         collectionView.delegate = self
         collectionView.showsVerticalScrollIndicator = false
         collectionView.showsHorizontalScrollIndicator = false
         collectionView.decelerationRate = .fast
         return collectionView
     }()

    enum SupplementaryElementKind {
        static let sectionHeader = "article-section-header"
    }
     
     var dataSource : UICollectionViewDiffableDataSource<Section, Article>!
     var snapshot : NSDiffableDataSourceSnapshot<Section, Article>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configure() {
        backgroundColor = .green
        addSubview(articleCollectionView)
        NSLayoutConstraint.activate([
            articleCollectionView.topAnchor.constraint(equalTo: topAnchor),
            articleCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            articleCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            articleCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        articleCollectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.reuseIdentifier)
    }
    
    func configureDataSource()  {
        snapshot = NSDiffableDataSourceSnapshot()
        snapshot.appendSections([Section.Article])
        
        let articles = articleDataSource.getArticles()
        
        snapshot.appendItems(articles)
        dataSource = UICollectionViewDiffableDataSource<Section, Article>(collectionView: articleCollectionView, cellProvider: { (collectionView, indexPath, number) -> UICollectionViewCell? in
           guard let articleCell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.reuseIdentifier, for: indexPath) as? ArticleCell else {
               fatalError("Cannot create new cell")
           }
        articleCell.articleTitle.text = articles[indexPath.row].title
        articleCell.articleImageView.image = UIImage(named: articles[indexPath.row].coverImage)
        return articleCell
      })
        dataSource.apply(snapshot)
      }
}
