//
//  HomeSectionHeaderView.swift
//  CrowdShot
//
//  Created by Soni A on 22/12/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//

import Foundation
import UIKit
import Combine

class HomeSectionHeaderView: UICollectionReusableView , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    
    static let reuseIdentifier = "home-section-header-view"
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
        handleCurrentArticle()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configure() {
        backgroundColor = .green
        addSubview(articleCollectionView)
        NSLayoutConstraint.activate([
            articleCollectionView.topAnchor.constraint(equalTo: topAnchor),
            articleCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            articleCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            articleCollectionView.rightAnchor.constraint(equalTo: rightAnchor)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @Published var artIds = -1
    var subscriptions: Set<AnyCancellable> = []
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let aritlceId = Int(targetContentOffset.pointee.x / frame.width)
        artIds = aritlceId
    }
    
    func handleCurrentArticle() {
        $artIds.debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { value in
                print(value)
            })
            .store(in: &subscriptions)
    }
}
