//
//  UIHelper.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import UIKit

enum UIHelper {
    static func createHomeFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let cellWidth = CGFloat.deviceWidth
        let padding: CGFloat = 16
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: cellWidth - (2 * padding), height: cellWidth / 3)
        layout.minimumLineSpacing = 16

        return layout
    }
    
    static func createFavoritesFlowLayout() -> UICollectionViewFlowLayout {
        let screenWidth = CGFloat.deviceWidth
        let padding: CGFloat = 16
        let minimumItemSpacing: CGFloat = 12
        let availableWidth = screenWidth - (2 * padding) - minimumItemSpacing
        let itemWidth = availableWidth / 2

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth )

        return layout
    }
}
