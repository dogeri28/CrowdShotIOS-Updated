//
//  HomeFullscreenLayoutManager.swift
//  CrowdShot
//
//  Created by Soni A on 02/01/2021.
//  Copyright © 2021 Thoughtlights. All rights reserved.
//

import Foundation
import UIKit

struct HomeFullScreenLayoutManager {
   static func createLayout() -> UICollectionViewLayout {
        // sections -> groups -> items
    
        // item(s)
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
         item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 4, trailing: -4)
        
        // groups
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.interItemSpacing  = NSCollectionLayoutSpacing.fixed(10)
        
        // sections
        let section = NSCollectionLayoutSection(group: group)
        //section.boundarySupplementaryItems = [createSectionHeaderSupplementary()]
        
        // layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    static func createSectionHeaderSupplementary() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(240))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top )
        headerSupplementary.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        headerSupplementary.extendsBoundary = true
        headerSupplementary.pinToVisibleBounds = true
        return headerSupplementary
    }
}
