//
//  UIView+Extension.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 02/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocols

protocol Loadable { }
protocol Emptiable { }
protocol Printable { }

// MARK: - Tags

fileprivate let loadingViewTag = 11111
fileprivate let emptyViewTag = 22222

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

// MARK: - Emptiable View

extension UIView: Emptiable {
    
    /// Shows a subview indicating the view is empty.
    ///
    /// - Parameter message: Message to be displayed in the subview.
    func showEmptyView(message: String) {
        let emptyViewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyViewLabel.text = message
        emptyViewLabel.textColor = .gray
        emptyViewLabel.numberOfLines = 0
        emptyViewLabel.textAlignment = .center
        emptyViewLabel.sizeToFit()
        emptyViewLabel.tag = emptyViewTag
        emptyViewLabel.center = self.center
        
        DispatchQueue.main.async {
            self.addSubview(emptyViewLabel)
        }
    }
    
    /// Removes the previously added empty view.
    func hideEmptyView() {
        DispatchQueue.main.async {
            self.viewWithTag(emptyViewTag)?.removeFromSuperview()
        }
    }
    
}

// MARK: - Printable View

extension UIView: Printable {
    
    /// Generates an UIImage by printing the visible view content.
    ///
    /// - Returns: An UIImage containing the view content.
    func asImage(bounds: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image(actions: { (rendererContext) in
            layer.render(in: rendererContext.cgContext)
        })
    }
    
}
