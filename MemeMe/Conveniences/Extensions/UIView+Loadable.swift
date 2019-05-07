//
//  UIView+Loadable.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocols

protocol Loadable { }

// MARK: - Tags

fileprivate let loadingViewTag = 11111

// MARK: - Loadable View

extension UIView: Loadable {
    
    /// Presents a subview with an activity indicator in the middle.
    func startLoading(style: UIActivityIndicatorView.Style = .whiteLarge) {
        
        let loadingView = UIView(frame: frame)
        loadingView.backgroundColor = .white
        loadingView.tag = loadingViewTag
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.center = center
        
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.color = .black
        activityIndicator.center = loadingView.center
        
        DispatchQueue.main.async {
            self.isUserInteractionEnabled = false
            loadingView.addSubview(activityIndicator)
            self.addSubview(loadingView)
        }
        
    }
    
    /// Removes the loading subview previously added.
    func stopLoading() {
        DispatchQueue.main.async {
            self.viewWithTag(loadingViewTag)?.removeFromSuperview()
            self.isUserInteractionEnabled = true
        }
    }

}
