//
//  UIViewController+Extensions.swift
//  DeliveryFood
//
//  Created by Олег Федоров on 05.02.2022.
//

import UIKit

extension UIViewController {
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
    
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
    
    func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .darkGray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        
        return activityIndicator
    }
}
