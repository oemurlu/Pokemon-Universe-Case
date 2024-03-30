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
    
    func showLoadingViewCenter() {
        let loadingView = UIView(frame: self.bounds)
        loadingView.tag = 999
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .label
        activityIndicator.center = loadingView.center
        activityIndicator.startAnimating()
        
        loadingView.addSubview(activityIndicator)
        self.addSubview(loadingView)
    }
    
    func hideLoadingViewCenter() {
        self.subviews.first(where: {$0.tag == 999})?.removeFromSuperview()
    }
    
    func showLoadingViewForNewPokemonsLoading() {
        guard self.viewWithTag(995) == nil else { return } // Eğer zaten bir loading view varsa, yeni bir tane eklenmemesi için kontrol

        let loadingView = UIView()
        loadingView.tag = 995
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(loadingView)

        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            loadingView.heightAnchor.constraint(equalToConstant: 60)
        ])

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .label
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])

        activityIndicator.startAnimating()
    }
    
    func hideLoadingViewForNewPokemonsDidLoad() {
        self.subviews.first(where: {$0.tag == 995})?.removeFromSuperview()
    }
}
