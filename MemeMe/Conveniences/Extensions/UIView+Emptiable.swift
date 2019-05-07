//
//  UIView+Emptiable.swift
//  MemeMe
//
//  Created by Andre Sanches Bocato on 07/05/19.
//  Copyright © 2019 Andre Sanches Bocato. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocols

protocol Emptiable { }

// MARK: - Tags

fileprivate let emptyViewTag = 22222

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
