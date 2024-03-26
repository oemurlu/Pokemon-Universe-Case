//
//  UIView+Ext.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import UIKit

extension UIView {
    func pinToEdgesOfSafeArea(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
