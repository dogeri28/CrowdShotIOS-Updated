//
//  LayoutManagers.swift
//  CrowdShot
//
//  Created by Soni A on 07/12/2020.
//  Copyright © 2020 Thoughtlights. All rights reserved.
//
import UIKit

struct HomeLayoutManager {
   static func createLayout() -> UICollectionViewLayout {
        // sections -> groups -> items
    
    
    // let height = floor((frame.width * 9) / 16) + 80
    // CGSize(width: frame.width - 10, height: height)
    
        let height:CGFloat = 180
        let fraction: CGFloat = 4 / 5
    
        // item(s)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(height / fraction))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 2, bottom: 4, trailing: 0)
        
        // groups
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(height + 40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = .fixed(1)
       
        // sections
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createSectionHeaderSupplementary()]
        
        // layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    static func createSectionHeaderSupplementary() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(240))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top )
        //headerSupplementary.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        headerSupplementary.extendsBoundary = true
        headerSupplementary.pinToVisibleBounds = true
        return headerSupplementary
    }
}
