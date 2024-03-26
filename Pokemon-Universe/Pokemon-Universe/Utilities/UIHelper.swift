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
}


